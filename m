Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289B4CC63C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542948; cv=none; b=p3fsDn3G5l1f/ipRkG7VP08X6m7mz6UFTrzSPzhI4vIosQUPeX4L8AXC/Rpr5t1RycBMbUW94hmygpg/SZwRDvNh1CtL/mJ4YBgf1AgdutoDv7RLP943D3OMTb9w/k3k/Cbv7tzOP/vVSNCcN3kASZrl84neofPRZ1NaLjT9n4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542948; c=relaxed/simple;
	bh=+7n+VAOK454JUna7O7impUHUVNwkOJp2zE2SB4yifz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1s/qW06U7hKmsrQAEhY1FA8ivhJpM3RB+Vyt3hsRIORCeievq7l5R5OezgHnwD/4WCTzN3cODmW1X+Uif2caDl7ZGmCE6bxUp0EDaSudZRAsYWFNtBnVTAEBaJ7Ef930xecy8vzsaV2m5cherX8InkGwugYytod5F+lQ7ecw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbT0Y11A; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbT0Y11A"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1068388a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542928; x=1792147728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZq7SPo9Y/whhStQfkD4IvVpMX9n+LJXWJy6ODrbTsM=;
        b=QbT0Y11Aew9cGvJ4YzDBQtJlkFAPfXJRxSeCstWDjKaT29axsD9RXic+BR32ZwZU2W
         4eQSt5tvA/Kd+S2joJQR/IJW2VwuiW+YmToo/2GeiRK+3RTYTMiGUmBqI7pkVJyBvW+h
         vEBc5w3wbnMa8N1Uszds/xpvQCnJcpUUe2Tvhw4wzHH5bMfdrQlVS6xfyzRFicDf98W8
         dau33oVVcNp8Edj/3PyvGTC8mz2Ha8+vSYn+YOlYo77yBl64TJrwMn49itiYTTJUD+Xg
         1fV1Ou/HcDEju1IcKsGA9pzjKVCYFuaDz/6zAQ/lzg23VjcX1niW+ouq8xmlYj72vv2T
         zs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542928; x=1792147728;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZq7SPo9Y/whhStQfkD4IvVpMX9n+LJXWJy6ODrbTsM=;
        b=wGa+qRIQIhMXjatD5sPGgzK0j8HX0O+eOLy265RLktVGwe6Rw/t+uJkts7GuJtsmpj
         mMf0j3CkjifIfiwrxn3F8kwncmbKWktzeikw9bEWPAuEin+38CwTe5rDR103IvDGU6lq
         WcAoeOiZ6k1nSW4t90xc4QRvlZJNSuZ0A22Dp+Sb65JbqHlRsWfVSej1Fu6/j2plo/gt
         O9dgNLw/i4mTCdVw6dFqjgOh/KhskNo7qrsIQAS81U1aat1I8fBSGfg1f+n38vBxgkWs
         MV56hMaWCYESl/PLt4z+SFW+yQNYXaWmJnAcR1MjROF8u3uPM0tSpn5EYjtrg6fc0jx8
         UEuA==
X-Gm-Message-State: AFq9FYL6LEd8YyMPrq/3kQ7icCT6q+xkr3CJ7+OZSM6ICTIAvAE6l0qE
	EMHc54qDV3N+yujI4owtLtLX9liaCnAL/FLZGEEBgmVEVj0s9E7ZzI2cdqea7NBr
X-Gm-Gg: AYBFou0Szy5pKIf1y8sh60/WU1OJtU3nVtK2xWtLVIGigdUmh0m+ovyX1BbhL0ZSbWW
	37MwkWXhBYbGxeWgwSuHd61y58d8EoJMkpcmqSmjZqpfmWxvrk8cth50VWZ7y0QVoSvjB9BSdSD
	vywq73R0d9I0SHZ6nUfgU3hD0Rq+qk0GqwWQJWtk4casNwaI/dZmzKF3TO/KOno0QHdD/UqjJL1
	HJzLV88YjKfJG5+i7Yz5Vxw9u3k8xm2nNAbShuSwQ5FxjCZO2ERYWHQgNBqAqMvs9bai8jEuZ7v
	37xJVRy6okjPRiotvOWWKZFIkH57hXfz93gE6aCvoKEfM5g+4r52R2oadK4tZMH8Z1vjWG962r0
	V7ni2/OamlCaSv5ORPoGfOkQV4OaZEK/ljYtcfD1Ql2RXTcBc9TKF/i1WFCUPFpCluR0Uhn4qFp
	Y3xySIxUJhnGTdkPSV7NwScuKM/LTeOpjAUt4KObVrX6PS4Elh6a143E0f09ucHI4jfutZ6/nVg
	bRg5YD5+fhfVh2WXnj34eK1qA==
X-Received: by 2002:a17:90a:d006:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3ab3a953313mr789718a91.9.1791542928092;
        Fri, 09 Oct 2026 03:48:48 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 38/51] selftests/bpf: bound UNIX socket path loops by sun_path size
Date: Fri,  9 Oct 2026 03:47:56 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-38-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The bpf_iter/unix and skc_to_unix_sock tests index sun_path but bound
that index by sizeof(struct sockaddr_un). This allows indices 108 and
109 into the 108-byte array. With SCEV loop widening, the variable-offset
BTF access check rejects the resulting range.

Bound the index by sizeof(sun_path) in both tests. Runtime behavior for
valid UNIX addresses is unchanged.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c         | 2 +-
 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index df3d971b21e8..3061b148f338 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -70,7 +70,7 @@ int dump_unix(struct bpf_iter__unix *ctx)
 
 			for (i = 1; i < len; i++) {
 				/* unix_validate_addr() tests this upper bound. */
-				if (i >= sizeof(struct sockaddr_un))
+				if (i >= sizeof(unix_sk->addr->name->sun_path))
 					break;
 
 				BPF_SEQ_PRINTF(seq, "%c",
diff --git a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
index 4cfa42aa9436..c5c643064eb5 100644
--- a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
+++ b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
@@ -29,7 +29,7 @@ int BPF_PROG(unix_listen, struct socket *sock, int backlog)
 	len = unix_sk->addr->len - sizeof(short);
 	path[0] = '@';
 	for (i = 1; i < len; i++) {
-		if (i >= (int)sizeof(struct sockaddr_un))
+		if (i >= (int)sizeof(unix_sk->addr->name->sun_path))
 			break;
 
 		path[i] = unix_sk->addr->name->sun_path[i];

-- 
2.53.0
