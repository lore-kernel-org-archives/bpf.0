Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AB51C33F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089006; cv=none; b=ObjAgEPXiiYyThCGszrjJrRiIF8fAdiVyGayNjaXWP9rCdUN2imxhfU5dQz1599rO7SKA8VTD9acrLNVxPzGucE3+98hBVo4o84CRpWsc9/f4McdbAtSBme1Om7eljJTn5S6aeW7TM/guvIgOcK7ZBKl9AtnExuXk32aR+F8vU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089006; c=relaxed/simple;
	bh=pD1m0ePRQ90sS/c3NSViNGNAJbxTBIWurXZPVtXHgE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/UnqGBkAoI4L4lIrBA8xPrem+fuG1x9LT03pWoqog6WzUuvdlhhQmX51upcCAiCFXy3ZaO1NlJJX1FlEYevigvQVKe2JJHJ3vSWvQzz6L0FK8Y0i4TQnd/vCb7S94jJMAFvisyRSeGHJe3U4/D/JxOLez33nZu695w6612BZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4dgEtQI; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4dgEtQI"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4858bc96fabso9777f8f.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089002; x=1790693802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gbf5D/Qb2Uh5GvQijbxTit0dkMqEzLpdwd2/LdNq8Y4=;
        b=U4dgEtQI7M2C78XdXYBef/anKygIfufVzE/niS8lrbeE45HT/Id8poFS4A+8buRrSM
         fHW0djos1L2DZiATULEhO6lN90792fKGD/rC8SMNEr8iz72EXi3/JfRP8MQmaETrFRbo
         w3kcK60W3KcgOpzAriVPV5/07c0Fr3uIZRlYOadL6r2l71sGUQe7jmAm52L63xudKE6/
         KLogcyOmSbbCzKmSnWTkLx692k5SJ2MZ85q/74NH3nJuK/UpJpt/QwGCROkrWdHX6Hfw
         kk947bUAjWeEuqCERjMZy/bKtgR/OND7BkHy1HApsNPmkmTSHmmQXelfgYX+MRRspJFJ
         yV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089002; x=1790693802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbf5D/Qb2Uh5GvQijbxTit0dkMqEzLpdwd2/LdNq8Y4=;
        b=aVxQcxYyFergHxHGxaYQ7qn9tugVLZiPsHQCjNZSyCWMPf1Wsdo3IQswDjw9Bk2Zdh
         gLK0BT1azajV5taa86C17bEfPX01TjnLOQ66InoSE+6SJQSF+SSOOJmCIsllEfrmLE7x
         U0KviyLdt/ubC70sW40fkzErED5JcpgtwI0W3OoKxh4eHfpfwoYh9m3z9TphE3gUX8JK
         w7AUG4S89S50uVVOFfBO6aCQJYGjEV9l0GKHm7A+N/xXOFWAHpo+wPIJT+lumzUU0a5M
         I7PoRGc4Oyz0FMT4nMTi8gtyBfWGns7KX57QwoZZMPNjtq6taJqCMckAF9+Ve0OK/tX0
         H0iA==
X-Forwarded-Encrypted: i=1; AKwUvBxqrU141PvNi+g69AHJEwLRDR4//Jb91zsTKMAD6DSML3saC4bps4JYuBpaKP6HFML+25I=@vger.kernel.org
X-Gm-Message-State: AFuF++mlNu71IbQh+FPLeHLE8NAZVS/E9v2B9khbm0/YwPCT+ojpcucp
	zLrhVs4XfpFgSAiS6/d2T/Yk49XXNExWYEOOdA/feJ5Ny8n2YgVHW718
X-Gm-Gg: AYBFou2P9qIIVX0JU6uWHLtM2xskva5ZUqd3ywa3GozwDjV40rliSU3loRN3DGN7/ua
	cuZsVhx4pv4ZDP6yBvM3Gb1Cr61Os7pNBIOJoRTLQnCYu0ThVN16/zSNFunmZwRKDHV6EpNJftl
	ww76WVAELgoUXPrF5JHM/r72XeF2kiV40dNaVo3CcfYQ5hE3zkg1J8NUBmKXXEvM4Dg29ius05Y
	AA32TzQ5B5envH7a86+0bWgqn2XHF+inaJ4A4Vptp3hs4RsBP45xn4uxdeAiQjOUSGZotGGPoAn
	v2SCMUcc6DAk8nJrD6KY/BG5yMgy223tkl9udphZsOZu9RH3GgbPX+2SeF1fVqJWazSsLJz1xBt
	2Ws4t+eXkRpcHz63A9sHd7k+oro8vXVSDTL8EeVXM9lHe6P0AzOchJyi6eT3c+E7rGMDW4LzgrT
	KSAzsqxvR0iiSOyv8/TUNFWGmVs/8og/ePLVk4rsBxMAFWCFOW6UfQQ7FdNp98ooEmBjORhLynx
	0g5EpaS+/bPBH74/ofVKi47Ojrn0MDHwmMpwv3olyaPY+unnX8eJmMVsCD4mFv3ryopTyrrIR+v
	7lju
X-Received: by 2002:a05:6000:1845:b0:486:f767:8be9 with SMTP id ffacd0b85a97d-4871e244b67mr23497956f8f.10.1790089002313;
        Tue, 22 Sep 2026 07:56:42 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862788f61sm5638813f8f.26.2026.09.22.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:56:40 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: fs/xattr: don't assume the inode is locked in path_unlink/path_rmdir
Date: Tue, 22 Sep 2026 16:55:30 +0200
Message-ID: <20260922145530.369775-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_lsm_has_d_inode_locked() makes the verifier rewrite
bpf_[set|remove]_dentry_xattr() to the _locked variants, which assume
that the caller already holds the inode's i_rwsem.  The path_unlink and
path_rmdir hooks are listed, but security_path_unlink() and
security_path_rmdir() run before vfs_unlink()/vfs_rmdir() take the
victim inode's i_rwsem, so a sleepable BPF LSM program attached to
either hook mutates the victim's xattrs without the lock held.

Drop the two path hooks from d_inode_locked_hooks so that the verifier
keeps the locking bpf_[set|remove]_dentry_xattr() variants, which take
the lock themselves.

Fixes: 56467292794b8 ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 6cb8772679782..357a379ef92a5 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -472,10 +472,6 @@ BTF_ID(func, bpf_lsm_inode_rmdir)
 BTF_ID(func, bpf_lsm_inode_setattr)
 BTF_ID(func, bpf_lsm_inode_setxattr)
 BTF_ID(func, bpf_lsm_inode_unlink)
-#ifdef CONFIG_SECURITY_PATH
-BTF_ID(func, bpf_lsm_path_unlink)
-BTF_ID(func, bpf_lsm_path_rmdir)
-#endif /* CONFIG_SECURITY_PATH */
 BTF_SET_END(d_inode_locked_hooks)
 
 bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
-- 
2.53.0

