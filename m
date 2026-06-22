Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D70399D08
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133124; cv=none; b=vCKGuPDHze6tBY23E07AjVqRUnXJ13pfl9oyRQEZT2SbAFqPE6MsQc+/WEx8CPBl/niU+b53/tZZmT2tThDcDSitZ6jyeu0QsoaD0fzqiyyowuJTtPVZ2p9hoBJ+mWz5aNrZ2g0R19PXoNQNhjDHOhbimKhexd+Fwnp7nmJjOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133124; c=relaxed/simple;
	bh=qDElADXlgQyAzLqXp1zhsofyI3JFx7Kipplc8adrurk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q5rXlDZGUqJllVOoJ2MeqjsjDUKCrT+v22d29KTO9AGwd6AHRqQuCJuHhdh5zDzybWlC3yxAnpM0P38zUF22pJpu7fYq1Jge6ldRcP+7q5Xvl5/mUNKYAhzw+uMp6bG122a4W0KsivH1JWDpH8raplkFaVcScasqOdDc8viwkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rk+PzL82; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rk+PzL82"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso265870566b.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782133121; x=1782737921; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfzBz+UdB3nbzgd5M+T+mIKozpGs1yOUYWhHRThmvXE=;
        b=Rk+PzL82GGZIwxrDYvSGS5tXANJhuLAG0DxXL2bcis3Ekg3+lUp6jYQi7zwN/2CHAR
         1kNnHJihnBQ3YVCswJqJty8q6sKFjOqYxkz+cO30Q+CByUbrSOwn0aP2BajAULOF2rt1
         OUmEb+SteutEeWqYJr5IEOKeCx7vXnFAjYQ07sTuzmzr4FCxncXXOnPD9zb/cFUbICj+
         TRWRv2VYLmGni2ik4xoSMD5vefpDBxPBLxHshBEuOPNMlyM8fT32d2kmKvXPBx3gOmR/
         lUZB36g5FJ/Q8Ikh9Smu/HdT9h5lDpzl/75kr3lhqKladELHXRMS/uiJFiRv0+m34v/G
         aA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133121; x=1782737921;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfzBz+UdB3nbzgd5M+T+mIKozpGs1yOUYWhHRThmvXE=;
        b=M2CNJcgphdWwOvS2VSS9JwyJ1fSIqrdtqkl0Oq5HR+9ObJ8L2fOcDI4dRXL5yOSJ5S
         XbdfTepgbDl0XIOz7kRI8vxzAAi1QKpHfZNwDh1uAkDcjYQDP3uUkn2fv1Buq6We1iWt
         IowQkvi+lTEfTphL1mz0StpbAw1+O6qn8oUg77SaY8Rmly6ajUe0ngHqhrUOQtBHKeqS
         OLyILhCkCxToqa9UHw1lshapiE5ItmNA+3QJJ0/h9ebAhhO/DL4LOyq1Vdd292hjXfEQ
         xmf/IuAqfogUJLaLqsI24QNz8IMqLlg3/KNFTym4zIL2l7AUrBAK5gOesTjPv8xwrpob
         8vkg==
X-Gm-Message-State: AOJu0Ywg0NB+ydA/sO0QQc0X1LbLTqr6AdurTOY+asZUSkzuXoh/kjt/
	Y57A4/8P2oJUgTMVSKd+MNwwIfpQizbe2GLnr01DHZiimhxQkgqlYv0vGs7B/3xmnzk=
X-Gm-Gg: AfdE7cmwgMlcmx3eg5YFxAZQY+cF0pJYTkEF2TAFcBF1Sji95uEGRSZups1cq4tze5E
	gq0SW6CiC2QgBaFEXcwb5WBFIIkK588zz73gVJ+5AJvLWXkVRJLCetzvTetTZ1rf27HpihCKRXT
	ldKvQUS1Wneih3BAOuvcheek7Uv901Yxtgy+f5t8600S2FGEdsN9UQcRTED2UamJmwbZoESz46D
	K/jqI5GbAgbvHzwuMO+W/Aaaq159m/MgNxEUhpsyuUtuVFuFWT4swJhPuROfZv+u36zf+rGLBR4
	X2ptoJt2yePSwiV2wokV3ax7xifaT2vibZHSqNOftOusGCxSelR4s6QQ+8c5YLNcg2b62R4M46t
	QexgKnRx3vfjeYpjOSRhf9nDg8dlSxMWNdDWGbgkQz+rxktpxhgEs3p8ABS9SlFtDKzZg7UCkgH
	xNKXvSRRZEIum7k6Pw/TehZQWGk8F0EfUXnZw3DfRBFxC3IzyjdRUor03pvXs=
X-Received: by 2002:a17:906:6a29:b0:bfe:ed74:523 with SMTP id a640c23a62f3a-c098f12eb0emr774449366b.50.1782133121181;
        Mon, 22 Jun 2026 05:58:41 -0700 (PDT)
Received: from cloudflare.com (79.184.207.15.ipv4.supernova.orange.pl. [79.184.207.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60bbf2b3sm352712766b.39.2026.06.22.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:58:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 22 Jun 2026 14:58:34 +0200
Subject: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAHkxOWoC/yWMQQqDMBAAvyJ77kIMYsWvlFKaZNW1bRqysQTEv
 xvtcRhmVhCKTAJ9tUKkHwt/fYH6UoGdnn4kZFcYtNKtarVGEwaU1+MjI0p4c8LFc0Z3rRunSDW
 dNVDaEGngfH5vcCSecoL738hiZrLp2MK27f6dcC+DAAAA
X-Change-ID: 20260622-bpf-sk_msg-split-unix-d714d0e048cb
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/unix/unix_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index f86ff19e9764..5289a04b4993 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -7,6 +7,7 @@
 
 #include "af_unix.h"
 
+#ifdef CONFIG_NET_SOCK_MSG
 #define unix_sk_has_data(__sk, __psock)					\
 		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
 			!skb_queue_empty(&__psock->ingress_skb) ||	\
@@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	sk_psock_put(sk, psock);
 	return copied;
 }
+#endif /* CONFIG_NET_SOCK_MSG */
 
 static struct proto *unix_dgram_prot_saved __read_mostly;
 static DEFINE_SPINLOCK(unix_dgram_prot_lock);
@@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct proto *prot, const struct proto
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 }
 
 static void unix_stream_bpf_rebuild_protos(struct proto *prot,
@@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct proto *prot,
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 	prot->unhash  = sock_map_unhash;
 }
 



