Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692995;
	b=2aXvBCW6qqYOz2ZCKFui0YM7lElqSgFzje+YjbGxSabSaP6Ilanz7z/3fhTOi9P/+8FG
	 asO8F1dxPmFioznBZrOH6I1g0OY/LENQwceVECIyKuSRM4+NVHYqRPnnD3c1MThLT5EF2
	 o8KHFqzP9AN3bXjWzDu5tu0WhsAkhoQl/WpxVKUSurwHJT00lRHujRHPsGD6ijmw5ZXtT
	 4zD833e789LB9Viu7U/Ljdi+5RdcSHDHiEyf42MErivyrH8frAVkoJva8k+fvO70bCmHE
	 OeUJ2p9HrLfIrg30vHKu30gAVe+GZL+UeZnDwA1DvRPTbbSvoK6nuaxkVxwc7ZUAVZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QeAE/97LSA+alBszF2d/9US4us/V4a2d1RN7juhfoM8=;
	b=lxRx71ev37ao1rRr3Fw6bbtxC2TqppEdP5zIbFl4VEgAnnN8rQ8yRSm/AI/zPhCJInfe
	 PN7mT3czPO+edS/5OTx6tSVnGxNFCiTaVkzvcMKPCw++DGVhUh850J3wJGgjkk5b2yonC
	 CCR5P/QbCy4QQoe2PfGJVO53nlZsAjNpDKXXgAlsuOIIYH0xPWxMT58vYIfrmqekOPHAP
	 sAAVfWuFayXIyuJEqQWFsgMWIsxeX6oK7dhrqHTsxHw5Iy5AwCGa8cqKvNnvpluVxQMNx
	 ++NEjG2w+I3NU+4IiyuCPNkkwBTwkAbAGY72GwsQlSLAZ92/jwa6n2F1Kmei7FI1AQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YKhRC3q/";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8977606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 18:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8977606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YKhRC3q/
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4649b35bso82246f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792692993; x=1793297793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QeAE/97LSA+alBszF2d/9US4us/V4a2d1RN7juhfoM8=;
        b=YKhRC3q/p2rLW80Q2JhcknkVIWplOdKZw10QYqUbrLJ//XuZVCmBH4rm6MChmHL+Ju
         X8jWc+nftxbKSDqEUP4esKdNDIF18cTPUCkTqv9S1agUql2ky1HVZ4bQSqr+lfMRz4F1
         nh5YIE9aQ6hAw+yC23fOq70aHFhGCfWR8wYenT2iZ5w0H7iicikHpCqgo8ivOIvROOwE
         sE4OZ0D7D/5YhqYaJs0jeVjZQH0eGY9Ay5a+RDrnWGtmL/NkI6bhYgL8WFYyr/7JkWr1
         o1zMi7DrDje01CXwjtLLZqDlwHzuLLbOZwOqx79fByblZs5+rDxr6IwUsg9vTFsNuZX2
         Incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692993; x=1793297793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QeAE/97LSA+alBszF2d/9US4us/V4a2d1RN7juhfoM8=;
        b=XMIHdhC6geOWNZGGYEVC2XdYDHyq3+LZKTrDM+2d38Hfjz08IE8+APHu9GnlSQN2mw
         llJLJOG9gdba78z78rVrGkUsr/FUMGDCp+igzp7tUhFE3r1PVE/u8otmRu0woQg1w/ES
         pP8jroG/jng/tJzrcjn+NsfrvVcpKgTpw5v0J7YQC61Oa4Bzsd/xJGCVJ83WjUGKp90X
         P1mRXklFK3160nCHlrRDoUHMd8MPCq477sKRs0iUFBJhmfzfnZpHCENPe9WiY6f7+YoN
         4RJbkg/FSGQzOOT5t1GQfkK2nYzyJ4eRgDiYKHhbemH2c6e4skeYD9qLN0wNKwRIxYCy
         luUQ==
X-Gm-Message-State: AFq9FYIm93w6qadKq2HAe965l+LvuNztN5gvgjFm+o2IGzd0xOjQWZ1r
	E8LXE0wFy9KQdbKN7KCn2Yu8X4jtRJuGKFTEt7mc4Rja8QgTMF8+eDCquUQDDd1NEKAfyA==
X-Gm-Gg: AYBFou3StOKgClgggOOsxUWrYUpfIazEqU3Zk1T3wSC0F8ICL6b5b7CcFNRk/fYwzBu
	epW76ol2tHJMOv/gesMlMCBKVcBcQrZf4keNb1nm6ozthpnQpUITeNP9PCfO0xuj2Hp8B9d8oRe
	Brd8T8WyZsJhFzt1r6xPCvvWlilUu8/Z8Dd1qEbIUbHLE+puxnjAeeRNv4NCtlZ48XLjH+Ep8ho
	8aXzBFb/eKDr0ojmsuJdF8ISATjSKReDp/1XgS4FQTd1nHKTDI/F0+8x3qdt5fPUZ87c044HNaR
	aKIuNRXveMt/dsDjZflJF1gPgW6FGhU+svGwS/2TjyYYj73JAejH5/k6TBOKpOHl8YMQ0ZNqJOZ
	An5U1wS4fHCOHprBaJlkda1kdVI2Yq5ivhJM/JZzOvhWWrwbDasROQZ+24uUzMpIvH0x+t1nCjy
	E/KztdFi/gkfxrTrRnGwzsUQqQFo3eGVggG7yHoQGvGTe02KIGIhD67gzDu+Zq8C4bKNdzC+Irn
	ksg38S4sowaHLLnexOiE3zERv3UEQtpcMBWSoI5wejmz4BrlsKelc2Ep29HpO6nVVs42/wh8zvj
	BdiGnnbareXNDMYZPoziWyZII3VyIeWLNbYAdVtkXfmfyRp/
X-Received: by 2002:a05:6000:240c:b0:48b:f92:1f67 with SMTP id ffacd0b85a97d-48e264898b6mr12509309f8f.21.1792692992923;
        Thu, 22 Oct 2026 11:16:32 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3796b2b4sm18451f8f.7.2026.10.22.11.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:16:32 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_ksock_bind() kfunc
Date: Thu, 22 Oct 2026 18:16:19 +0000
Message-ID: <20261022181620.247201-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Part of the effort to make ksock have all basic socket operations. This
is for example useful when replying to a peer which expects a message
from a particular source port.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 37168f43c16c..c7b487d90cd0 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -178,6 +178,33 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	return NULL;
 }

+/**
+ * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
+ * @ks:		The BPF kernel socket context.
+ * @addr:	Pointer to an IPv4 or IPv6 socket address.
+ * @addr__sz:	Size of the address union.
+ *
+ * Binds the socket to the specified local address and port. A port of zero
+ * selects an ephemeral port.
+ *
+ * This function may sleep, so it can only be used in sleepable BPF programs
+ * (SYSCALL).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
+			       const union bpf_ksock_addr *addr, u32 addr__sz)
+{
+	struct sockaddr_storage sa;
+	int addrlen;
+
+	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
+	if (addrlen < 0)
+		return addrlen;
+
+	return __sys_bind_socket(ks->sock, &sa, addrlen);
+}
+
 /**
  * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
  * @ks:		The BPF kernel socket context.
@@ -285,6 +312,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_bind, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)

 static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
--
2.43.0

