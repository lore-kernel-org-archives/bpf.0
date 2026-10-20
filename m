Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493536;
	b=1tP4b0cVazE4GyxBQ9dq+itbAN6QmUBN0Z49oOZp5vi3Hsl6AobaIX40dPx4RC0oQw0v
	 Ul878vv9UwRRI1gpu2cr702NHXz7+Op+R4Avsv+rlNUnufRTnqcNTXq63k/dkfhHGeQRH
	 vGuKpE4fYRmmLd6fM8OxnvaOvOJsB1NYTuhqfmci6Q15JCIYyIEwi648N4H1qVh7CKgNx
	 wieuvHx3r00RgHQj1m+35ThiSk+kbRt4ScNr/To2+zOmLO1UkNpPkkPNpTdRlcQm8Xs+P
	 QVzz+O1U3NwhawMSFaMFOUI1P7m2W/MtE3gqCU7q5vQTnHntK5lJbl542pseY37FtNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493536;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=fMvWIQiVeXksTVschiof9sJSZQhCHQiDXoi94hJip8g=;
	b=s3tlbKCaTdewGi7tXniun9udBaWxEUsH9DtivqqPlFa43dCsj4VjzUb2JKLFggxmbk1E
	 8AqlC4Ql/iNCdy/nhy2889/MKsVHPcJx8RRpICy6b3DT3m0YkXs5iLg9UMTNjMi4LcNY8
	 spplwDVsdmnWlkIM9ds/Dyemi33zm3iJwubn131eNt1GOKgJwkI4uMkdlbE8atXFrFlY7
	 XWYEKZ1wGgFXW+xD7eiZkkWcjrULrFzHff8NeM+nTXgVoPElrXYskqSZ7S+R48z0Zly0l
	 Ic8J2gowXM+hbjhZfjH9ZwWvIWfHhB/SXXiuC9toqxS0xkgdwwRMW7KTdrQrH2VPEZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4ROAHa2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD1606A319;
	Tue, 20 Oct 2026 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4ROAHa2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064561F000C4;
	Tue, 20 Oct 2026 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493535;
	bh=fMvWIQiVeXksTVschiof9sJSZQhCHQiDXoi94hJip8g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D4ROAHa2eEyZd6tUFe2yMEelBgsfsKVVE05phHZ5RnsYTFF7kp64QqTrk6tzZfLYA
	 EnMoBUYqjiyIbMimSpNo/x+QOjTVxPaMkCi69poviwrG133dzrUqY5OnmEn72xJMzp
	 kB5Mtto3nxbsAAvIS1U83VF935dlH0YTyrR+CBa6wC+HYvFZySX7WBYM79QtmG3d8j
	 0LMBPCpweuNA8Y5t0oV3QFbTqw+wfND0hY7BgvNRYz+8NizabY/b2LDkL4Sf2+/TVV
	 RZU9OxPfuK47pOF38Dfc+8eHeUvZ4wb/WgBdGlXVCk3XurvXggYUC84YspwytdeSxj
	 4Q1d5O6VjoDew==
Content-Type: multipart/mixed; boundary="===============6036520422771328630=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <af7818e22b8336b796a951e86dcb6a63c8ed79e8643e264cfa8ba147e83b594d@mail.kernel.org>
In-Reply-To: <20261020102512.518479-3-mahe.tardy@gmail.com>
References: <20261020102512.518479-3-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 2/8] selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,willemb@google.com,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,horms@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kuniyu@google.com,memxor@gmail.com,emil@etsalapatis.com,almagui@kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 10:52:15 +0000 (UTC)

--===============6036520422771328630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test allowed bpf_ksock operations at send LSM attach

TL;DR: Commit message only: it names ksock_socket_sendmsg(), which isn't a
real function or hook and is renamed by this patch. Suggest naming the
socket_sendmsg LSM hook and mentioning the rename.

>     selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
>
>     This test makes sure that bpf_ksock_acquire() and bpf_ksock_release()
>     can be called from programs attached to ksock_socket_sendmsg().
>
>     Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

This isn't a bug, but is ksock_socket_sendmsg() the right name to use here?

There is no kernel function or LSM hook with that name.  It was the name of
the existing BPF program in ksock_lsm_verifier.c, and this same patch
renames that program:

-int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,

so after the patch is applied the identifier in the changelog refers to
nothing.  The attach point is the socket_sendmsg LSM hook
(SEC("lsm.s/socket_sendmsg"), i.e. security_socket_sendmsg()).

Could the changelog name that hook instead, and also mention that the
existing program is renamed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39408886865
--===============6036520422771328630==--
