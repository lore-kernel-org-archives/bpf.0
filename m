Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830019;
	b=tyal2WuR23g/kljnZqOYje8b9dZzeWaqRzLtyVk+jnyhXuqjzqxho+V3sTvtot29b8kJ
	 f/XWszwXLqNhUORnOR92mrChteFnPGn96ZdPgXD0XG/kmLnVBR6VZ+ZH0Yfby4F+wS1sz
	 l5LqV56UwzVE3ytdMWOKujdpVV57ZwNallX3hHQr12Zala2udN5bwRa3iG/Q/7NhiTcDT
	 VV0H/zQtWwXcpgOgfV/N1QKLRl1lsz7BqJYy4ff9Xu+yAxh/tzhiFR88wIWkPTi4EguQr
	 jiN6CNWRdhh/kmDTybq0I0uBg2wZcrKctt2yQX1wzbYWse5SPRN43bWzb2hmhGbpb+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nHzuwXTeUvCdPppRHxMn98Th6DR4G6YORPkOyi+dvbo=;
	b=VtlKaupUDX92P8YOsvyGF1w/AzAUES8yvOuqfULR6vNTC8N4c9tktaX0AVle79PXprW4
	 ek0koi3EDdNoYPtzzCjKdwz4r/x92PWm8WA18OrUMChdckmSQnNiaT/8EqjeU8YUa1uSq
	 1o4LTf8VQdEfzLLVtex0HeNnZXF5+0kqVj3O+ryZPVxEewn7+fS2wcRWJlNFXQ2/cuk/V
	 2ugHqRXmBAMAtUivJTDaYwYhL8cpngKXQqCQnzJ1K1SbAk5ARPWIvx5XNg3hLjS3GIzBr
	 xPMDBEDqsfHaWM07dXgisdV8RTZU4RQFvkwD7WtqbFRcUDAKYqq5/guSsMUZ3lG1ETA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q+j29iSJ;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E88606A31E
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E88606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q+j29iSJ
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so4982889a91.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795830019; x=1796434819; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nHzuwXTeUvCdPppRHxMn98Th6DR4G6YORPkOyi+dvbo=;
        b=q+j29iSJxxoGRSE7F1BSeZcwvPI2mVgZdsm7x/iBZmNEPXFEggoUPsany6GgqPf49N
         /WCfN6WWWcsv78zTqQFJw+6S4CNLeaGaCBRB9fJpCLiXasH2KydEsCWgbxRG0xLDDxp6
         R0abfDF6sPKD1k3vrcfRenL3is4HryeHnzsb+0WNeuw5ybnn5mJOkxw/Z+xZpNvmkOXx
         a2MWyrzJxnQqJjEbJ83Z7fgtgGTnx7iclNLHAevNJwBwt+jzKKWRSQZ2RChsV9JzzBXV
         APdCwTcI4b06cCuyG5Yz3gEXqd64yFqH8/jRVSK3u1ny8aOBh6wF07CNuf8cZMVpFbwb
         UGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830019; x=1796434819;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHzuwXTeUvCdPppRHxMn98Th6DR4G6YORPkOyi+dvbo=;
        b=1MjlCOQjJc7w1hxITt3TNI7JI5wNieojiwnsEGQ9RJMCkCpwC6c3TbLt3ijVS8OOQP
         +R9XRDsK2iYEkR5uczyl0wrVK475B87OTAgScP3Iq02eqEjgTVpdPe0Cv6o8E+IL8fyG
         SwJkbSSCYJv/0OiALZjCF/McIcRa37sfaENHZk0s9Bx7G0z2cxPIqyWAQQ3ucG+Etycx
         lDM6eWWpthhR5z+/Sk2rMHJXasYg8HhkJtRpt8DqL4LGXR08wya87lnZ9Nj0NF974Ybk
         dm7MyQ9Phr3PmWDqOLkdvIq4jS59vCq1rp61kebRlrDMgOMg1InubPsd2VVtXLSjJ/p8
         SjFA==
X-Gm-Message-State: APuU4Z+EbT3v0zt6LGfYUzaaoVZgQqStYaP5NnHCoU4+Ae10Qx6iAJxC
	btomY1ChIQ4mp6esTJjCDpdACfsqXkNwD7aQ8ugyCXHFKyVUadxYWRAw
X-Gm-Gg: AZFdTZfXwZaO0MsYAtPF1VQYL1DQraBxNRUaYGfaP8SG3afow9FMIZEOzkufVJjHSXn
	G+mk4v6Qj8/TvVLe7F9Wwsj/C1+WG1RcUOruYqANGguU6BS60bA3hhepSgy/i4o3rM+iHo8fUTe
	n3nU57pr1ybxxO9To9NeUVStnKfY7VKPJJfK1N6C8BGk9eyxeszYtwkqzdP7FO3en19wKBXnf04
	U8s2yX6VIa0bq0CPlil/5JgEXho9p7LsM35QBpY3suKz0ni7CyKOJyVnKasmQ4PmjeYptZLUudC
	l+Fdv2h4q60UsRNVdkpwuMr1McgLX0ZdR+QSA3K0XrzXWGb1TO/ZA/DvwiRg4ZOxhqQqReLOKaC
	NCuZtOgEeBgvsZM2sqMKqDsMM8pvNoc+0fa+TnL2bWmq6DMtgdi603pM8U7k/NpP4jVxvn++y9w
	A7zB0yhrsAOHw7H/wHvWVHaNdrYvhdqUZbsdPcTFIVYBqrhf92poFLV8f/gnisWeuYmulc9LiqU
	F/Gbq9Bk4U4h8WhpLPZmd5RtlPXOkKG/TZDFVbPVxAtkxXDAuwjAOSchNVIRKH4exiJTxGwe3fw
	3KMlWfK3AzSwlHdCs5St5hToBEw+esn0fWld07PN5cSWTD1w9cAO+qgkVO16ieKxrwwRg8cyS6i
	EtqaZiLHTjiBP5mNNGAxEHamhoYuMGeQrFQ==
X-Received: by 2002:a17:90b:3ecd:b0:3a4:adea:50ad with SMTP id 98e67ed59e1d1-3b41c9e46c6mr27425363a91.27.1795830018596;
        Fri, 27 Nov 2026 17:40:18 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm40440119a91.4.2026.11.27.17.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 17:40:18 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 01:40:17 +0000
Message-Id: <DN6GM0YTCXII.2LIEDQV0KFDM1@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: Drop conflicting DWARF choice from
 config.x86_64
In-Reply-To: <20261127-selftests-bpf-config_dwarf-v1-1-46ef5b492f41@marliere.net>
References: <20261127-selftests-bpf-config_dwarf-v1-1-46ef5b492f41@marliere.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 27, 2026 at 10:03 AM Ricardo B. Marlière (SUSE) <ricardo@marliere.net> wrote:
>  CONFIG_DEBUG_ATOMIC_SLEEP=y
> -CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y

gcc 11+ and clang 14+ default to DWARF5.
This moves x86-64 from DWARF5 to DWARF4:

  arch                              today              with the patch
  --------------------------------  -----------------  --------------
  x86_64                            toolchain default  DWARF4
  aarch64, s390x, riscv64, ppc64el  DWARF4             DWARF4


If you care about cleaning up configs then drop
CONFIG_DEBUG_INFO_DWARF4=y
instead.

pw-bot: cr
