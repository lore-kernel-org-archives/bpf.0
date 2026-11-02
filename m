Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636333;
	b=00ttVzwxvKB8mHxJTkTubZ9KJKmpj0ulzF/PxplIjj0Ou+Edc37mcMCEA6G0FUoRqnDl
	 mxN6GIV6GKaXTaU2RjhiD+FOG1UxiAEtiIKxvveDW7QBCjVFgOnjoGoZptCKbE4kOi0qq
	 PS8hyLbBtEu69NKZvZJ5KNul+wf843Lwo8HbKbeHUx9AqaqzwfZEDxSu7NSUyN1O9LTC0
	 OIgmv0nphAOyMx1dYtrugwZQp2Vj4ysZs8CDn5OKn82j99985fG0p++jnSKkOD7VL4erK
	 Fqv1drIPFyb784Rf1wifXDItLWjThDbYwYfA4PEqBXGHnL4kG84kUr1JjWkpGykGHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
	b=S+DwMsaPkVMFN3lnfDXZXwsjs51FXc/wI3JSCdVSVTQ6DVpUszYzNUtobWOAcHrZZ1LM
	 JUnPr2Y1nLVV/mzwCTiX/s5VzETgveotQJc46d0poHckNjPoh8PcWoT+3MJf0cTMVieHO
	 N3dwFBzeOw5MHFqaxQwfCec4WnmD5ziz5MoMJeKF1AcGZjpQmSSHBOhyn+hbAMIqXXU94
	 AiQwpQKOa9coXr3U1rlbTZMFh4fMNHGO4dkSFjmSWMAM5zxRhd3bP/Cg7nToJUgh0dKkj
	 8MwvkOq7gWckdoz5nWOuc0qsQlD0te/7nw2sASptcdFMgqDBHTH4I4Q+AdMUK6iDQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qr00LX+p;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB66083629
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAB66083629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qr00LX+p
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso1302767b3a.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636332; x=1794241132; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
        b=Qr00LX+pev5ohEtqTqwX9gkiynVq25vhLr+e0eaMDZhfvf9ZZ/ckaoGlLeNVkzsn3U
         z3fECQAfpsWMzOpsx+WeUPEk0FHoQSB1IbeBGyH0MiEMgIuRfCiaKZ50Mms8F31V0Y14
         RETjtUeT68Su92/VmC5kW8OcY2SBCFj+HCwWUzHeuGPGaBmkVk01Wep04XpjWv6o4TTl
         DSFaAXBHP/MnEQMMLPrWOJCglF5fKifuNvjPw5SIwmd+il1bYxcuhUr744SmNd4Kqa9e
         MZM76Wa3aQbJcisGnBZWgh2q5LuyGJrx1He8Yfi+4wNbGPjfO81TOTxME4lmJ7dFz0Ke
         6CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636332; x=1794241132;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
        b=f0A0FeTZRMaD0nC+AIIsFS63OPse0rJw8Piaw1brvssV330DTHgM7mSU8w7i8icgCD
         OyA4rAiuOd80uCPH0gsny20PnvTY55PhAiqsIgmJ2a65bgu3fBkrHng+XRxh+pWRb5DN
         NFbC2lyPgMdEu+if4a3BnGMrTsi/1bOdMTr7/raNFT1d5xYd+8AU60t0qViBO0u9j4UK
         5VAlY6ULWRtYy1mHlCIOS7Bc8pCqDnSn3aD53UIzE7gv2JQypqHIpvjbpev0PJJAfH7T
         Y5bmyGwV+Y2mfUovgYmLZw2BrCHYdtU48NsikU4W8Z1w3iK9MqHGz95Vs4MRS8j1+Yqc
         K16g==
X-Forwarded-Encrypted: i=1; AKwUvBwih0KoDM/yFHtTncbDdbBGPVa8rOr6i4/8/j+cdh+IJaapZ9e+pxKdonepm9BEdFcs1Ds=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnDJxLz5vYLKXZi97AxyYoNjUJTnDExxrZjNnGnlfa0QqdAbwN
	oQWoMb8BzQPFGFZ6oJ3De7HkfUtxhSDEkBmpSPw0IjdtjuuXo8Uno8k+
X-Gm-Gg: AYBFou21eBmKNRG6aNWEi9v/cr5qjQCKhwAVFrPABXBXSKTVV4+n5grWlcKDqUOOZG1
	RQhe96qA95GxdOB73NsO/yjr5IL8f+KiOYf1KsKaxecotCZ2X0iBldDe6g9pos5LUXkXuVL0xXg
	9qIhbCLzQVD5VkB9xqWk350zEzfp6sEgaEOQLRExcUXYAe9fVNkLdtg1gISAXE0ZIDvb9VligSA
	KbGR4h2rzLtcB3feGDphu1uo1t5i4UUi6LS/h45n8rgcjRSZNRNgKUeXZddudbI3kcKNJbHaeOH
	j9fxzsnP+656J+h6GXCJ2vdz3kLw0ZaI5dl2ClCp/JbmVHJWUQCDw/KsWYj5VoiLv7Kgt2XLkco
	Y9VrC5/03BiTOxIXBZ6eaL7IfOGVkNCoLvKuwXPlha/n9V+7TIxenY43tfAZg7yC+1iEPmtmxhu
	zAo7YD41bVPJo+bSc4F2ecpLt/UXqp9FVGQfSM6IvQq/VDt3BPpp+n3JrXCkU5O0XY7vXI6PaM7
	2LgMSJg7hNcH3BzBxcC+Qp96GrIfba2u0Z7V0hDhqdz+OI/IkgIq07juae0VHnrOPHHTrNJswqr
	ykNJXGrHD2P+M/+rW3u+3q5z3ehGPNlfg9vtkQx5QeuAg6fHVhDsdn8+ZYsOe2qxt7SZypgLojx
	NSA56LY1Ny3TFgwPOcKVkSkdUST86GMKAByyPvVenk4ur9Bys2rZ7g/Q=
X-Received: by 2002:a05:6300:8047:b0:3e1:7b85:5a95 with SMTP id adf61e73a8af0-3e928ce91b7mr8254146637.28.1793636332340;
        Mon, 02 Nov 2026 08:18:52 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d03424sm2308383b3a.24.2026.11.02.08.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:18:51 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:18:50 +0000
Message-Id: <DMKV0IW3XAU1.3KSPCJSXR3Z3K@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
 <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an
 egress redirect before each send
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-8-alexei.starovoitov@gmail.com> <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
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

On Mon, Nov 02, 2026 at 04:32 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> I can trigger it by redirecting data to a non-accept sk.
>
> ==================================================================
> BUG: KASAN: null-ptr-deref in tcp_sendmsg_locked+0xfb8/0x4550
> Write of size 8 at addr 0000000000000008 by task repro/488

Thanks for testing.
All patches have reproducers.
I didn't share them, hough it's a weak defense.
Anyone can build a repro from the patch.
