Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58996260588
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288388; cv=none; b=PuIo0CWwvITBA022JwCaAZBDTobHaJFx8pHCzK9FCN7NMTT/yCCEelDxujaNlMEDZic5+rLPDIGZ4fAWTvZTOjMeynmukqEIRVCrfhiMiWk1ZCE3Ef+JPKRwVmA013GWI/d4mdmVSQqe8RuIZoofaWqkp3LzhSUmElvYP27wyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288388; c=relaxed/simple;
	bh=FntRL1qpxfsNfmvPILCwbU6dqigMGKuJ0zJnx7gXrxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgDsWvczxshwQE2Q08MCHVKDbdkrdhVcTPXUb/NhebwY/56G03w/XuoQLHDzaDLiT5Xo5riQDAH4talmYaHLopKDJYgEHJHNsSWXb0f9FW+J3D4RUhaeNpb+ipgOeDibkMTw+AyVEmk+qSthNJGPwkhCMGtIeZ5FEFVCEdbmW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=TaZk3GHv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="TaZk3GHv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359a302794so617961f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 02:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770288386; x=1770893186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pI+I8Y4vd8PrLGBnjDW8Sa0zt5Y1hsnun0xp3Gdhd6o=;
        b=TaZk3GHvcIEe2sT+plbieP5K2VYopl7ILZjpw4m5IHR16O9JXem0J9GvruTYqwJwzo
         phVz2+hSLhhob1YfzZo+BYuvdb7uipF1JFO+X+UWPi0LlSr+Pgs8Nqli9x+tBQfFvtyG
         mYOGqORAEAfAo28anmd2r8YSydNK/zGpgBfRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288386; x=1770893186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI+I8Y4vd8PrLGBnjDW8Sa0zt5Y1hsnun0xp3Gdhd6o=;
        b=rhYJjmQaByRb+c6ubYQZ5PTz5mSsjJkR24imbBEOI3Zu/9dg6SXWZG5pUMGe5yHjHt
         mLp1hC77gdxrZ+op4HI0ATtdBeyFzI71Xpa/LJ8Ri/7dYY9otSVEKgSvkVtOpPRp2nHZ
         J50+jn99ITj7yqUCPPx3zoLWB/VMYQbghVjpLoG8uDLuE2qR1aRhSZtb7AzjkXK5FNlv
         5zBmDMaLgKjExrf48YaoHuKETG7LK3/4NjlR/4cOGktIJlpOv07ws5nKfg3RW5Ld0lBU
         /5L2erjE2urQLcxOftSQPHbu8T39zZZ6zX8eMQDPAbNnv28b6Em34XM34SL0qaLiRuYw
         uAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5px1fCqWa8keV5670KSdOL2kI17u5OzPu1GryqEzkSJdLanPx/+7+4AsdYTC6QkH2N9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjU7szd0IKfy1das3ecZWrxflbhRNHVXtV7b7vWbw4gzWXfHv
	2TLndUqF3uolMh3IDCxW5gGiCcQJ4/4TnEBSHW5EULXHWEbjT4Cr3TEWDiNdBV3QpCU=
X-Gm-Gg: AZuq6aJuJoaxYhUjiFcLhI7k3tacUBNDvD3/+UXxMREAGplTwOFpdWCM8tlXIcLhO01
	vzycd+LMm9+PGcMcL2oHrLVuddSBVdQPm01InlU44C6kKDuvlEA7xwrkoygEeTHcgM+OmE5JnGE
	l/04qijUuuGnONSZ8GhZdt5eRFrdjy2Rj3ClxM0EPwmC4Cqgho3v1L5g/Jkn9+G3/MTXXeXiWNv
	5uDa1W4WY4OnwxOQWAUPb6ig9XdgMGjoWd/AXtPcUqUx4gbCVKKlHeyeo4/Ja+eZXd7pYhJ7nfe
	U+NF2KZRwtkFHpXEglcsZZpkik/twFz79lMry19FNujHAQLOTOr03I58wx2Et+WMFbpPl3pfngl
	Bp7tQAGUarnwFVQHO+ecnKr0/LPVegFI4PomgUxVhpqlTB8x0jCIPSDbO06xikKQI38PvjHWCx6
	j7NXxeFUMV9EoZQveBkKBaWygfBQB3RrPoYw1dq4RhesLZZ6TpbAzxyuTWLAvDPiB/6eNSS4VmG
	pM/fnoLKzE=
X-Received: by 2002:a05:6000:2207:b0:435:faa5:c154 with SMTP id ffacd0b85a97d-43618053a3fmr9052159f8f.37.1770288386357;
        Thu, 05 Feb 2026 02:46:26 -0800 (PST)
Received: from alex-laptop.lan (p200300cf574bcf00678f3cb95ec6a9da.dip0.t-ipconnect.de. [2003:cf:574b:cf00:678f:3cb9:5ec6:a9da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f66sm12351476f8f.25.2026.02.05.02.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:46:25 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: ast@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
Date: Thu,  5 Feb 2026 11:45:41 +0100
Message-ID: <20260205104541.171034-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Instead of FS_USERNS_MOUNT we should use recently introduced
FS_USERNS_DELEGATABLE cause it better expresses what we
really want to get there. Filesystem should not be allowed
to be mounted by an unprivileged user, but at the same time
we want to have sb->s_user_ns to point to the container's
user namespace, at the same time superblock can only
be created if capable(CAP_SYS_ADMIN) check is successful.

Tested and no regressions noticed.

No functional change intended.

Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
- RWB-tag from Jeff [1]
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/bpf/inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9f866a010dad..d8dfdc846bd0 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *inode;
 	int ret;
 
-	/* Mounting an instance of BPF FS requires privileges */
-	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
 	.init_fs_context = bpf_init_fs_context,
 	.parameters	= bpf_fs_parameters,
 	.kill_sb	= bpf_kill_super,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_DELEGATABLE,
 };
 
 static int __init bpf_init(void)
-- 
2.47.3

