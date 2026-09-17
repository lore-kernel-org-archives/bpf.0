Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784E4F4CF7
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661650; cv=none; b=RpFe5yAtXKk66eVjTXAIAzx9sRh7Be63rZU5lxxyDwsCV4zsXeSrnzKSa3901jqXTHOZRaXHbwvU0AzzLgNr74Q+XAm/jDId02iVCUttkGFWydBb+PDytTTbSsGEkc0NxuBvllmoKNu9HZjAp35EPfAoDGalKirBx/LZSeCN1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661650; c=relaxed/simple;
	bh=CEQYbOWht2A7b+OZw6MvQpQz1NKPJ1hneP2IMPR4sXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljEpREf+P+gthbpEA6MYortPSf66GQBGRrNwqPMGxASKGWRVmGqqZ/p9qWB9yT13iGZNS853cZAWAvptPsfESNIzVYq5tAQAvKITbDF9AEYJEfxDKlQRQQZTFGWecYmKtA1untplm8DaonxZv47WW7eaKTMWSYNR9HYlATO26bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlqHyv1X; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlqHyv1X"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f38so10628745ad.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661647; x=1790266447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x8bSU+iv17p+dmRAzgAgwO3BTC71XsPeXgtmHePe98I=;
        b=dlqHyv1XRsLqDp5qUOXg+/wJ6kuePbWyEjwqg5LTns+wG5J1XsoZPp/05zOFlcUEK7
         XY2ZI0tsUi4subD+GCcnr9gkFh3ZjHWqlrqQiE0QgN/jzFkUcb0sXbaUknzDpFGLpVz+
         aWrysSgYPF2C5WmkHOQTDRxYUhdjt2mXomqv6KscQF1Qfs5DpRR05S7JWCoEJTdYYjua
         rfoyqm6yQbSMwsJUZ8mwyHwBCscj4hXEQPYz3ltpGtNolU9fnGCEyXATAPwZVbIsqu8R
         fVlN7r2lVwjrxjS6ifB4Wt2wYSme8fptWBi1CcVeJZG45uhY41B1InsksZAmk+uNj2AA
         8lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661647; x=1790266447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8bSU+iv17p+dmRAzgAgwO3BTC71XsPeXgtmHePe98I=;
        b=0sYCykapNVrxDGrBt5am1u336O+8OJJ2JD6EhDU/dC/7yzdiQFf4CzbZJsdNg5sEqN
         Px69P2961EOhlTPcWJrHQcdzSGP/OEfKYah43izX7g8GD/EJuxdC+AqY9Xz7dcnbl3cN
         HoRz4wW0Z57otIcNeU5jdVGffqaRRfOMrPWLJd7fWLob+cQueg+sBPfo7PZN1CkzsKeY
         uoVVZ+ZXV5B4PLVXEz6K90WR8+8P4TicJxGLVuj0Ok7SEfIpQA3BY+q+cBG4WFvRikMp
         9KQS1Pnk5/P3ZxF9P7/+RIgpxa5hD441SYGb2NLrk636olVh4KbIB/3ZxSrN2egdfrPE
         /nhg==
X-Forwarded-Encrypted: i=1; AKwUvBxVYKAD2VHSHXfcpVwcvVK9a0zSyofQGR08XDAdTm9yDpqYojPILDs4b8njpWoyDY0tf6c=@vger.kernel.org
X-Gm-Message-State: AFuF++kavUIh1OnBH1UfNT+v8jefD+nEwtwgxPVTipLAwM6ZkrAA34LJ
	lQcdDP0flk7m4CnhABgnob5zGXKgl5KZZBx2gz5ob5lRkyQxrc34Rk/J
X-Gm-Gg: AYBFou0W6Fh4T/MznqKzQ26HfPi0AgsSQseQR8IwSsGYgUe/GtScq59+j5vmJy4nhqh
	Jwf1/RigaseHRc5lgxiXzrNwZHXaxmSiHeSFAKDEM6u5AYCoKiJJU+yIaXeAxN3I9iPmLooVJ/U
	Js2kZbgPs3QSHSOLUUpi6gR2NZqPhIEAj7MaBEl7vAEau2p4FPg5+CLE3W3ItWmMnTsj/m2bT1z
	QAzMMhEtWdEJFHidiIILeHVJEAnsh4aECvtRh8WhhBXn4oYQ+Uuo5IpyIAn7Z94SbGMGoAXjgR+
	1wYpccDjxH1FARuqPGaxcF+6r1JkDqGVMDCGP2JeYd4otUIbD6IoUf3qCS93etLvnao7D0NPz1b
	Z080XkYT8DQxbqjdLI3BT+QjPh6iI6fEs6oVIi1d5iXLt90Gcmw4oxrCaNIIcTKJwa7gp7DS28u
	o9+eSrvohpFq8H5Z8KmtuSwMecG5FuW4dggtowJAdm9KeYTBRkSS0YP7s5wrTppUyDf1njaN0DW
	UXBB9TAlWX9agXmRtUI6SaNR9ZM/gbo
X-Received: by 2002:a17:902:e94f:b0:2d6:fd55:3a9d with SMTP id d9443c01a7336-2dd8dc06da5mr150178695ad.3.1789661647417;
        Thu, 17 Sep 2026 09:14:07 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fd37sm29489395ad.3.2026.09.17.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:14:06 -0700 (PDT)
From: bestswngs@gmail.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+ac0a8c41de69121d@bugs.sh
Subject: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
Date: Fri, 18 Sep 2026 00:13:36 +0800
Message-ID: <20260917161335.1020405-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

__bpf_offload_dev_match() falls back to comparing offdev pointers after an
exact netdev mismatch.  Bound-only programs normally have NULL offdevs, so
unrelated netdevs compare equal; one loaded on an offload-registered netdev
can instead inherit a real offdev and match a sibling port.  An attacker
can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
metadata kfuncs specialized for the bound driver on the target driver's
xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
stack xdp_buff as a veth_xdp_buff.

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
  Call Trace:
   ...
   tun_build_skb (drivers/net/tun.c:1739)
   tun_get_user (drivers/net/tun.c:1856)
   tun_chr_write_iter (drivers/net/tun.c:2091)
   vfs_write (fs/read_write.c:595 fs/read_write.c:687)
   ksys_write (fs/read_write.c:739)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Restrict non-offloaded programs to exact netdev matches and retain the
shared-offdev fallback only for genuinely offloaded multi-port programs.

Cc: stable@vger.kernel.org
Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: <co+ac0a8c41de69121d@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/offload.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f55695..8c91d00d4 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
 		return false;
 	if (offload->netdev == netdev)
 		return true;
+	if (!bpf_prog_is_offloaded(prog->aux))
+		return false;
 
 	ondev1 = bpf_offload_find_netdev(offload->netdev);
 	ondev2 = bpf_offload_find_netdev(netdev);
 
-	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
+	return ondev1 && ondev2 && ondev1->offdev &&
+	       ondev1->offdev == ondev2->offdev;
 }
 
 bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev)
-- 
2.55.0
