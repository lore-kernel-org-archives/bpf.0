Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E137E2FC;
	Thu, 23 Apr 2026 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918900; cv=none; b=JDbwop0yQaMJUrJhEEWu3j0PNZiwsMyunE8B4czG2H3qDCXM8jovrodOBKnsyQvTi30ClJPbxTvj4jckXIJmhJ6+WkLpTnxzC1lX/yMQIXwZu1eJ/MkYrc0kzaolp9S/jnyeL4ALwowNQfIUNOYtt+cPqCK3SxlR0dHLCxUnFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918900; c=relaxed/simple;
	bh=aWvRukeb3/SOXFDMVWfbsggVIBpozqoP0j6lX8sg/Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgqJu0U78ipSd3JWNjFpEP1WbThr6Vi4khoor2UiV/uJGwSbZI84fMrAmu3EN5jtVJNDkteggN/OiEZvaN2eLMcEdBfX2bcqLUg9Lt3YH5uoSUrkECRwOiLcG86oIsjR4W8/z2ht+gbDMQ8b/VAcKe4h3pVuwurFyI5Ef5D6WQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WQWj8ui9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WQWj8ui9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yZ/1TXJa0GapOTTk8uc73pyvGncz6tST8HAGrt9lFcI=; b=WQWj8ui9gfxapgYl6c2Xb/W4ZN
	b2BgcMIaVX729pWpwPZGibA1wQmcH9A/rodCujm+kEiAeNXISJym19bZyCAeqL61RNywydmzgYa/d
	ntRP/e/GhDJFlOqHePeoE9csQzNc3e4H6dgax0ENDm7wTj6jyO4rJPetnnKxGCmBs24hG6IgsfemN
	ggdDwgubs157KbNzq0+4ujM3bkLDjLH7gt4Hvq0DUt3DjVunZv5FkF1m0WOYpJkYK6GPqPOx4YVzx
	VatbeTn1j7RBY62gfs+wYNr2II9nBKO7cgOoEs2Bf31C/F/za9yC295bZq0bT8AEvf/1hZXwSspQA
	YRb0H0mw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFlqE-00000008ZbN-0c7m;
	Thu, 23 Apr 2026 04:39:06 +0000
Date: Thu, 23 Apr 2026 05:39:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eulgyu Kim <eulgyukim@snu.ac.kr>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr, Alexei Starovoitov <ast@kernel.org>,
	KaFai Wan <kafai.wan@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in link_path_walk
Message-ID: <20260423043906.GN3518998@ZenIV>
References: <20260423013916.1589029-1-eulgyukim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423013916.1589029-1-eulgyukim@snu.ac.kr>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 23, 2026 at 10:39:16AM +0900, Eulgyu Kim wrote:

> We suspect there is a race condition between vfs_rmdir() and may_lookup()
> on the BPF pseudo filesystem. It seems that while link_path_walk() is walking
> a path, its call to may_lookup() checks permissions on the current directory
> inode through nd->inode, and vfs_rmdir() can remove that same directory and
> trigger inode destruction, leading to a use-after-free.

Not really.  What happens is that bpf does prompt freeing of struct inode, instead
of having it done with RCU delay.  Everything else is a result of that.

What's going on there?  It used to be in ->free_inode(); who had moved that into
->destroy_inode(), why had that been done, who had ACKed that and how have I
missed the discussions on fsdevel?

<digs>

commit 4f375ade6aa9f37fd72d7a78682f639772089eed
Author: KaFai Wan <kafai.wan@linux.dev>
Date:   Wed Oct 8 18:26:26 2025 +0800
 
     bpf: Avoid RCU context warning when unpinning htab with internal structs

[blocking stuff done from RCU-delayed callback, so let's make everything prompt,
whaddya mean, what was the delay for?]

Reported-by: Le Chen <tom2cat@sjtu.edu.cn>
Closes: https://lore.kernel.org/all/1444123482.1827743.1750996347470.JavaMail.zimbra@sjtu.edu.cn/
Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20251008102628.808045-2-kafai.wan@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

OK, that answers some of that...  <looks the posting up>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, kafai.wan@linux.dev,
	toke@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

... right, that probably answers the last one.  Incidentally, that commit has
brought back the old bug with cached symlink bodies getting freed without RCU delay.
It is possible that it was discussed on fsdevel at some point and I'd missed it
there, but...

Folks, the rules are simple:
	* anything that might be accessed in RCU mode (inode very much included
for objects that are visible in the tree) must be freed after RCU delay; that's
what ->free_inode() is for.
	* anything that can't be freed in such context should either be
dealt with in ->destroy_inode() (if it isn't needed for RCU-exposed methods)
or, if it really is needed for those, done via schedule_work() or equivalent
done by ->destroy_inode().

Seeing that bpffs has the grand total of zero RCU-exposed methods (no ->d_compare(),
no ->d_hash(), no ->permission(), no ->d_revalidate(), no ->get_link()) I would
guess that it's the case of "have your bpf_any_put() done promptly, leave freeing
the inode and cached symlink body RCU-delayed".  Something like the delta below
(completely untested):

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 25c06a011825..bd052a8e89a9 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -762,14 +762,26 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+// this is done promptly
 static void bpf_destroy_inode(struct inode *inode)
 {
 	enum bpf_type type;
 
-	if (S_ISLNK(inode->i_mode))
-		kfree(inode->i_link);
+	// better done here, since it's blocking and we'd need
+	// to use something like schedule_work() to do it from
+	// ->free_inode(); since this stuff doesn't need to
+	// be delayed, doing it here is less headache.
 	if (!bpf_inode_type(inode, &type))
 		bpf_any_put(inode->i_private, type);
+}
+
+// ... and this is done with RCU delay; anything that might be accessed
+// by RCU pathwalk (like, you know, inode and symlink contents) should be
+// dealt with here
+static void bpf_free_inode(struct inode *inode)
+{
+	if (S_ISLNK(inode->i_mode))
+		kfree(inode->i_link);
 	free_inode_nonrcu(inode);
 }
 
@@ -778,6 +790,7 @@ const struct super_operations bpf_super_ops = {
 	.drop_inode	= inode_just_drop,
 	.show_options	= bpf_show_options,
 	.destroy_inode	= bpf_destroy_inode,
+	.free_inode	= bpf_free_inode,
 };
 
 enum {
