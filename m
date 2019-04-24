Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A404BC282E1
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5D621904
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117877;
	bh=whJrikFU8Itb+EdI/4GjOvnT7vFfmZ25PfXvzCOP8Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bh7PWsaWVIm8GAQoQX0xUXzQ8AnIBDC/ffRttMWbW7fSoYZbDsXFRckXZ6IFd0ci4
	 DBPBEgEYo4xBaXtWKi9b0XV5K022ao9NWJIZBauiUY9sXA1RIgkMM0eTrrjL1bc8GP
	 728uLi08YbQZXxzNykMXcZadV/TvoM9NHGU/3fSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfDXOru (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732325AbfDXOrt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF08821902;
        Wed, 24 Apr 2019 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117268;
        bh=whJrikFU8Itb+EdI/4GjOvnT7vFfmZ25PfXvzCOP8Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btzvLskhtuwcnMJXoK8/L3bXF2aWRwpJHvXlGeso3XgzdAV8gnlcgUpZCLpEC/Vik
         4O5KPB2DGc1rFeEqa9Tv20TiZCwlfm8fDpGRaoRA5+QqsSbFptBazzbmoYe3Yi4XAj
         cURbYxVfr//jW1YHq4tl8/B2jU4fdy5n1D2bQCKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/35] debugfs: fix use-after-free on symlink traversal
Date:   Wed, 24 Apr 2019 10:46:51 -0400
Message-Id: <20190424144709.30215-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 93b919da64c15b90953f96a536e5e61df896ca57 ]

symlink body shouldn't be freed without an RCU delay.  Switch debugfs to
->destroy_inode() and use of call_rcu(); free both the inode and symlink
body in the callback.  Similar to solution for bpf, only here it's even
more obvious that ->evict_inode() can be dropped.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index ccfe1e1cb6bc..f4df6feec271 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -170,19 +170,24 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void debugfs_evict_inode(struct inode *inode)
+static void debugfs_i_callback(struct rcu_head *head)
 {
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
+	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
+	free_inode_nonrcu(inode);
+}
+
+static void debugfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, debugfs_i_callback);
 }
 
 static const struct super_operations debugfs_super_operations = {
 	.statfs		= simple_statfs,
 	.remount_fs	= debugfs_remount,
 	.show_options	= debugfs_show_options,
-	.evict_inode	= debugfs_evict_inode,
+	.destroy_inode	= debugfs_destroy_inode,
 };
 
 static struct vfsmount *debugfs_automount(struct path *path)
-- 
2.19.1

