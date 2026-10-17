Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4D345EA3
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200072; cv=none; b=DUWAshqTwYdpgX/8IKLa7+I9C27er3ebqJfrhDQ45PdbBbsegTr1ZNMRDMUOgzwCWV5Qj92D5SktuFMo5oFpjwIhlzj4TWdIdc/BJFlM94XKeYNsbU/pVYYIyPl+oqRQTYGqk/NeE+7U56JBOQm6B9yxe5WN4aHBQnk69b77JfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200072; c=relaxed/simple;
	bh=k1zvhGigGSPLpGn7I1t+Ecg+NgN2CKsqg5w0eDmK1Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRcxcKXaVEufvfmcNxF4l4zMJhTMMwjDZ8Ed3z4VT/6p4EntG2s23nhhKSpfPwo4vKnH6WJ+4JoI2pAbafuTRxJOUmoJqh5BDpW7ckK/ihipC1G1evn033IojSo9F86OG40fCs5uq9veCMiAaxAtgHRewnQEC5/rTWk1xs1JZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjwkqDun; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjwkqDun"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso372369a91.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200070; x=1792804870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=IjwkqDun5eJK5IhgMg/zSNoJizi3cxprs4LModvaz/X1Fre8Ogh6Vw4OpPJB+ffTfF
         +CDqGAHbeqpT2Wb9hCcm15f3HSBospXlXjkSJ7HRajnmHBL9uBzHH8x6fxypi84lxvB1
         gwl9ZuaELiO61wbdy7EafPQ2CQP0GgrXUSTWMx1LJfok4ETqkIxWQi2cD0u5tS6Rmhiq
         uCisBjLyqssY8FpPGiHQQ9COyNGh2jgV7EYCJKx9+gVpIaD5f9h05E0ljlKEbzeYJuHC
         TR/sL9YYdga0W4PX2WHxHnmTIJJu6wMwhyF1eEMwq/y3/wSy1ybOCP3YC7m3auOn6/GX
         0T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200070; x=1792804870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=omqpqADE1pGSgDP0KXBCJ1RgNiH7Era5BGsMKIMzRlUNZIxky0d8Bm9T8B0UDCTwiH
         JLxGdwMsvcEYnOcSaMZUTadndC1aRRQtF2xwciByue4y9VSG/Qo6vXEXMEryKAUP/Stm
         4hS8cJJKtb7UEl8fKGuV2SbPt58WmK8bTpNFZPU/+Y+H0vPnCYrRt8yaGHrEx8ZOo4+7
         9xBdm6I6/eDOA1Zm4l60eSt5EA1DUwr6is6fp4mylkHN6KUo0H4ZkCXwlQgJBg1p0sFv
         RMPmbA5Up+EPUkue6AwaXfBS7H55AV8Ehy7Fom5an2H3E1znqq0uu5MpxsYKiS7rMDGw
         kD0A==
X-Gm-Message-State: AFq9FYLgcMOIriXxD2D3ouPaAEUdpzIDgW0Q3zxznOEci3kfRRw9aHqs
	tRBdMhxNL/MuNIfwSnzcNifyg7taQFwtQfbafUNt1yomn96n24hH9OPyGwCqdk+l
X-Gm-Gg: AYBFou138cEnCpgMPgHgz0mRey5dc4cft/OWpYxKptjc+7SMl32mPV+rFQKQ7BC0I7s
	BUQfkf0nwpbPkz9WANlxbXZbkgjcK/RG3tbAvy/K/U5bWjYnTak2i3zupDiVmeD9fhY9oVl4gCz
	wMOBx2Z7ecSemhnoxeBYUE/2nx1aIOWNgJAEmaLeUWEb2rTTmm27j/zwRyhrr2TZEbts1IGexQJ
	aAgg4lJeSuLeCQJdvIwRezhGM9qUGvLmEknbNd1DgkE60f9U+tzQGiJkwRtUob3km/yRNRUj+nf
	k4DyCT1kt/aJEmXukPGArWG8fTBLBleI84oTrkRVDAttUI+aXVeNEkzQcaoLtIYVmjRr+DW1o0/
	HoAI0gDreIG3zVIDMAwDSaCI5FLaeWFKlSD07kZC/cM218pZvlQbgBCBQVC4npA1R/BEyxQiT+z
	/8VWOkvc4hRLmYypO5PY4fzO0pQwZi2kXVzNPiPNqSjyzyPeAlnvHqiJrVM+XA3hXoUMpZ1yB+5
	S4Jfw7p1PUK3aJKT18CHTmKCKE0YIFyH398DbBlaLJ57Jk4LfEc2KuX0Qo1T0YUHzGZ8Rdca4n3
	9Mrs7rRNB+KK49ARVeHXPEcg9XLKP6SWJjK5sCMXc0A=
X-Received: by 2002:a17:90b:164b:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3acef179290mr1109011a91.54.1792200070336;
        Fri, 16 Oct 2026 18:21:10 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm3407339a91.0.2026.10.16.18.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 03/38] bpf: don't leak the inode when token creation fails
Date: Sat, 17 Oct 2026 01:20:23 +0000
Message-ID: <20261017012058.355787-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_token_create() allocates a bpffs inode and hands it to
alloc_file_pseudo().  The inode reference only moves to the new file when
that call succeeds: alloc_file_pseudo() leaves the caller's reference alone
on failure, and FD_PREPARE() does not even evaluate the file expression
when it cannot get a descriptor.

Before the conversion to FD_PREPARE() the error path did iput(inode).  The
conversion dropped it, so each BPF_TOKEN_CREATE that fails with -EMFILE,
-ENFILE or -ENOMEM at this point leaks an inode.  A task that is allowed to
create tokens can hit this at will by lowering RLIMIT_NOFILE, and the
leaked inodes make umount of that bpffs instance complain about busy
inodes.

Put the inode again if no file was created.

Fixes: 981bec8f698b ("bpf: convert bpf_token_create() to FD_PREPARE()")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/token.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index e85a179523f0..19660ef95ddb 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -169,8 +169,11 @@ int bpf_token_create(union bpf_attr *attr)
 	FD_PREPARE(fdf, O_CLOEXEC,
 		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
 				     O_RDWR, &bpf_token_fops));
-	if (fdf.err)
+	if (fdf.err) {
+		/* no file took over the inode reference */
+		iput(inode);
 		return fdf.err;
+	}
 
 	token = kzalloc_obj(*token, GFP_USER);
 	if (!token)
-- 
2.55.0

