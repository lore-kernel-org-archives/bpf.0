Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511254;
	b=OmFQNhILRFwfVULKCCnWUDHPdaOSEiSe+Tq6rFrsxFDna7jpJV12vN55aQMM5EUbaFCN
	 pzI7JmMnlHFv8TNEDcenCWMNXfeC0bHgXqw6xy0kNDJB7yZnVCU+9zyauM7ZzPTGEx7z6
	 ogk+OVcheZGEc86tZOh9siQHfEtPj1kOEGfsedNpFsB4u07k7C/NjAZlQlQx8MkU2a1N2
	 W1DMWDb0wS4bDN3zgC7loSrWxAeTsgf5dZe4wlGVaDsHfuH1u/WN5XwBj2NdZFPGe3yuN
	 7SnlHMSQnknWPJnui5Wvn1sFoGiLIr4BzWb9DMVnAmFhwx5fGwcUeCLWxOd+s84Uq8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bfQ4W09NB0+NwKg8cP0sb9j3FSEtD3mmTAXdVQHhhdA=;
	b=1FR/CZ45LfDwoC/TuhWhVCMkL36k7IyeTw3cPaiCi4l5LblJYMPONrNtvEQusls0fwMS
	 171+0unvtLRq14zISvV62rytrW/KMCtFjXeMXY9mDaMjBkWvO/O9VRUPEfXztjXiIV1aG
	 TAyHFxujq6hSaSrvu00af2ifkqw5rZSshOt4aUWzRgjGaYO6b2ttXB+hfe9cNb4izPTC+
	 VzOtpy7z7wH4M0/rQ/RlyYnnPCTMTQJRI5qncZnZh+UViDyIHS8P/BY/2MvLuNpx6UQJo
	 UTw+67HtAnFqFStAMWCMNOQoWILkIYn6mYcRE8ab25fpzeWoUmhKStj1Xb/XocyFQrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=buJ4It71;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74529606A32A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74529606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=buJ4It71
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a01933b584so24285705e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511253; x=1793116053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfQ4W09NB0+NwKg8cP0sb9j3FSEtD3mmTAXdVQHhhdA=;
        b=buJ4It71iyALGLMB296yBXYeR9DXm3Sv7HZjHykmtoLaX8fJ193KGfzhr4+EUlwEYz
         ZPGUafAFm7IS4ADSvD+oVxe21jOxkhNeRzjeeeSZ12V8zxITr3Mc1a7Ruu/Gofitrb+C
         uebh1Fm9+GYj2iLfNueiT2tjYXXTIOCoBCECQTKxiUnR1mWCWF6GRVgX2akOxB2F2zwu
         Gu2WO+TckGSPzIEXc37Drfhx4DaT9fq+P+mZDKBVY8AJGkHL8wQqoeX1SvVToyDpF0wT
         kqaZFlgyETf7kNZa6w555CPnSC0lXSoEPROr8+ygZ/7D/yg8DykG2K7gmodAamLQ4L0Q
         pz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511253; x=1793116053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfQ4W09NB0+NwKg8cP0sb9j3FSEtD3mmTAXdVQHhhdA=;
        b=sLiEszid85yURtBn/F8hdo9A8pdPMEpdqQvPsCZkex9BWslfmHMPBmyDNSSM+W43w5
         t2ViP38dQlJA0RIVejgkpD3HSaegRz6BLplQJ7b8WNjEBB0rZxSFCAiSnBZduDV7XdK7
         JriBuAU0GPNX/4PBc1ms6DaijFajjuhutndAwcuYqncfdsHOhvoIL+Lwh0Yuf0wejNPG
         CtFtnRNCsswvmz+iOez9pT/vYLzVBCZhlw3oB5nngkzyqVJNSOd8cl31wVDF6iha3Pv2
         rMsQ9a/sFHxqpoa7PdLRDvwtRpHKHRlGbxklbUrYCvEtEZvuaxHo7j1anzGhlOD7PH4d
         jz2A==
X-Gm-Message-State: AFq9FYJ6eVPLqPhInSQuumjpmrpebqDDZz987SCrZee84kcMrqiNzhgD
	Qfpqx17x/6l8KtqxuyWdCOIGHOyFcUlO3cCTAwOENML6CnV/8pG48Rfj
X-Gm-Gg: AYBFou25aO9ONLvk31UOJYyJq6vKg8FXY8UruY8jFpGWbptR140QBzu2IbsNsmq2r/0
	3X71HWLN9nzL+XPUrhTmDqRvzPQDDbN4c2w/EWco2Z003wbk1wxOXikrin0949pCSflzlMWISRB
	NnU+rxh7+tAB/ZfuCO5tppYLQF6+HlGRaAeU9K3SXumAXknjfdaG8VtTYkajfvtPQBcp6GFMJJo
	SRNJpaobjy6fmZMdfzsmQSkguB/YlprYwKt+0PF0ExKm//SPOuQUOVDTB6s4hCL5VSPN7U3skJm
	pAnqQf2wqstv+1rjy54eV8EhfXE2QbpOxX4lryU060V0Xo8ygRnb3PYE48C+ru3aIDfVlnONjZ8
	A7+A9u1Qq6NiVwpfXoXIYybSBKkspK7P9qOmCtrfwQ8Ou/y1k7GHH5RTcFP1APQDr3MdaZ7rRlD
	OOBTFIXT7sJX9L16Grzqe9xnRAK3dV+JRNxMUYukAUVolF83x24rUPzxar3Tre/vQdCtmWwVxJ0
	6HKXPPoGoxqOMsLPmpa1F2JDGYFvAk9INuS
X-Received: by 2002:a05:600c:3b91:b0:4a1:e0b7:ff09 with SMTP id 5b1f17b1804b1-4a1e0b80060mr221153195e9.33.1792511250372;
        Tue, 20 Oct 2026 08:47:30 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d57ef7sm100402205e9.11.2026.10.20.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:47:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 17:47:28 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, willemb@google.com, eddyz87@gmail.com,
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
	horms@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, yonghong.song@linux.dev, jolsa@kernel.org,
	kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com,
	almagui@kernel.org
Subject: Re: [PATCH bpf-next 0/8] bpf: Expand ksock send-path support
Message-ID: <ateNEHabOb81MRLU@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
 <DM9RCU3BDWEG.1C32ZIVU95S76@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM9RCU3BDWEG.1C32ZIVU95S76@gmail.com>

On Tue, Oct 20, 2026 at 03:07:31PM +0000, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 03:25 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> > * allow bpf_ksock_connect() to be called in the send path
> > * add bpf_ksock_sendto() kfunc to complement to bpf_ksock_send()
> >
> > This is useful when using ksock to reply to differents peers while
> > reusing the same UDP socket and generally works toward the goal of ksock
> > to support the basic socket operations.
> 
> can we drop connect from LSM progs and patches 1-5 altogether ?
> bpf_ksock_sendto() alone replies to different peers on one socket.
> 
> connect + send from LSM progs can't do that reliably. The socket is
> shared through the kptr and sleepable progs run concurrently. Between
> bpf_ksock_connect(A) and bpf_ksock_send() on one CPU, another CPU does
> bpf_ksock_connect(B) and the datagram for A goes to B.
> 
> Without connect there, acquire/release in socket_sendmsg has no user:
> nothing can be done with that reference. bpf_ksock_sendto() is in
> ksock_kfunc_btf_ids, so the current filter rejects it in socket_sendmsg
> already. Then no need for bpf_ksock_send_id, bpf_ksock_sendto_id,
> bpf_ksock_connect_id, bpf_lsm_socket_connect_id and the cycle comment.
> 
> Selftests are left out below. Patch 8 stays as is, patch 7 stays
> without the socket_connect hunk.
> 

Okay, agree it's simpler! Let me send this as v2.

[...]

> 
> pw-bot: cr
