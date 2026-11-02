Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578356;
	b=04O4mmVPkMA7b+h1haHON19ISbt4ezV08C5KZ9oAxa3RQRZe2CFad/lEHjig3F9AxXgN
	 QH/uvv8Y2llCp6FprIV8LfK/pxVu86i/1n/Y2M48ybpH1gtwX2qBLAAXEz7TEZcwQypvh
	 Rs5QxEiyRD3/hJZNUc7b8YMZh9ypOhisuiVRT7O5QMI6WE5IF9v3lFwWGFhgUIKsEeIJx
	 BrLc/eRP5k0/gnLWIs52K9HnwqjREhJVfXCgiP0IYf0qBXhhYQEVCh8r44dO2X/RWp58h
	 uLbL04N9R+a2GXnrdV0tVKMvTt+iaNN+f4sfh967LoicYN0ffje8E0wwjcWriAY7PGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=cAv9lBG2C+jyRY+RDkZV1BaP87EnFyRTuzcZNJX0XKQ=;
	b=d6dDo5T16OL+9wI/5F8zDfq/9yOr9kJINvWX3tBUfZBjy0VyACxDiPZ501qKDLrqK8IC
	 73KjBEKGp0y8KuNPKaiMSs181m1AfjLtmwKGpnCh4Staaj3K3fzU6euwj+uTQxB49hKbf
	 xD3zG1eW7ATZJHJlqtONom63HuSVcX7UrnQ6q6nyNPbcf0x3zX9MV8/v01Gh9FgdnQ/nY
	 4vRpEXxBGNYMH8ROYCdZX+QBhL4mz6UWZXnT05ovom5po/4NWv2MQ7l9nWTSHJblvfKFY
	 pwdNnjm3dcsP1KyngTHm3W3UNHOfd3L3SOm4/wjeXCDneBz8BW+37nx+F8HsaBwlkFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5aBqER6;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF9606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15FF9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5aBqER6
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1483894a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578355; x=1794183155; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAv9lBG2C+jyRY+RDkZV1BaP87EnFyRTuzcZNJX0XKQ=;
        b=p5aBqER65p521uGcWWGQP24ik8o4lgs9e/3j2Ua7KIiT99HP7jH8vlHZ3AQo26BoAo
         2wDjVcoYBK3C02nzPtjwCIMJvfzv1eWV1ykwIUZDCCRrj2fHAkHUGUNTKPpE+D2f5kIy
         jpC5OcDVxKFLVeOz/MlUAb1YeVojy3Pf2ZrRC63/BCkgYq+kYdyh322RLD2Uok5y7GP9
         p3N+A7x4kXMuhywF/ahjmBTjYrIDyP/Tn5SIT5I7wL1zbmEicQHkQFl/FcYmhja9PlTh
         U4YJHpz04APaVI4M9bRFSq1fMjwLTw2ZUlMixkHoBzNut/QnyHnYS14Rz60YoAzsdCFq
         gPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578355; x=1794183155;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAv9lBG2C+jyRY+RDkZV1BaP87EnFyRTuzcZNJX0XKQ=;
        b=t8OFEHGHAA4Ti7Ecle5rZMcFB6BCvPQ+hTLEnHNhD8TTzdPZnPhmuAsn4sFVjv95V1
         dL0+OdznwxEwca811DE0yDMSjVnqkFwbVVw48wDbdSv5Fqej1/Mbo1h2W6i6W0av9bPg
         fQrGtxqvRBTiSMguAStQuLtSEu8cltbqkdsQ6CK5elTLWRayxTksZwUpt/HS0oIByOSn
         EpcbF2Ko74TFoEHMWiUa810GrO3C4TmFBgDBNoFag3Mr0xWEeSPuzyqzy56rd0EMC8bD
         6ppjgVvjoenUQegBZu7oycxL6+Uxgh6INI+J76yUJWjIgk79+jZLTE6MeNBlQBjzcqIM
         qHfg==
X-Forwarded-Encrypted: i=1; AKwUvBxMsmnG6G3MSYzsdWfHLx2XUWh32x/kcYVtmjUoByFsauouQw+cWw+k2U9zoPTzLNnRurY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u9k0uxSP+eF/DptNzy75w0muRFeJdaKHHxXbDAgFmXf9mWPHl
	Z/nejFlNSty1hYDv0rwfKgD9j2yznE7e76aS2D34GPcKo/PIa7sVP1nu
X-Gm-Gg: AYBFou2wiUZBSrC249vKUfx5IQgMe/2arLjMte1lFNnKdJStBvNjppTaj46/Iddg/8p
	QHto5EB3OjCpq8VVpXj5p4WLJBvA3Vvs8mWuK7AtoG/fCuBkQR7Z+qW7+5lgWA/K28DExSwOUyy
	6iqMxFXLflkkNGxrudA1G0qJrw55qnn+oOtsUW4N/aZy98KwSF+/4iOorPjbF9DsFHuvTeSGOAo
	4r0/R3E3Sxf03RqJs6YcSumGBtLT4he9Wmb8vLoXxYAkJaX7CcyT5eboB1Ccaqq3GWeyt1umgIt
	F51AvhQisWyg5C1NbOg5ictyohnljgCJvodJbhQ5mLvU64jdyfrGJvnWauoK09HTH1dMp66LzFi
	Jt/s1e/rWLIFI9eqRaFiPX0jBG7SWVxFp6AynPiX9r0Cjz5sXuTUZRrp4Eal0WmKycCNxPMlesJ
	2qGTezq51h8MmTqi8Z4uBcUPkHPJr50lBWzy59zfDQkz5Q0fbpDOYrzd+Sp0vjW7Fr3XH2zyhQj
	W7Y8jvjOM+4SMJYBwKyHf53d3rtwxYZBceyMjVV+KwabIu5EynluZJLwb2BfeIB8iRcnBxJ0nTq
	jhGaW1yoUvr6u2hNQ1q34h7V6Z848TUivErSnuh+i+5UlQ/003TuJhHdFcFXKj8qpZqXK43yHXB
	G3JJ337PL4rf6B9mWpPwUyUg93pADsMYYzA==
X-Received: by 2002:a17:90b:2711:b0:3ac:7449:40b4 with SMTP id 98e67ed59e1d1-3ae8981bdebmr6016839a91.45.1793578355179;
        Sun, 01 Nov 2026 16:12:35 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm15873506a91.13.2026.11.01.16.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:12:34 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:12:34 +0000
Message-Id: <DMKAGP1XUKZM.1MP4K4UV59IDN@gmail.com>
Subject: Re: [PATCH bpf 13/27] bpf: Require prog fd or capability for cgroup
 detach
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <josef@toxicpanda.com>, <mason@kernel.org>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <ihor.solodrai@linux.dev>
In-Reply-To: <2701eb350fc2a1c883cb6194a4b671e5e6316228e794651c708f967fdced78da@mail.kernel.org>
References: <20261101190535.1454146-14-alexei.starovoitov@gmail.com> <2701eb350fc2a1c883cb6194a4b671e5e6316228e794651c708f967fdced78da@mail.kernel.org>
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

On Sun, Nov 01, 2026 at 11:38 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +		pl = hlist_entry(progs->first, typeof(*pl), node);
>> +		if (pl->prog != prog && !bpf_net_capable())
>> +			return ERR_PTR(-EPERM);
>
> Is this check bypassable through BPF_PROG_ATTACH?

No. That's not a bypass. The prog FD is the permission to attach.

> This is pre-existing code that the patch does not touch, but should
> non-multi replacement in find_attach_entry() get the same check?  Or should
> the commit message say that holders of any prog fd are trusted to replace
> the attached prog?

No. That check turns the documented replace into -EPERM.
