Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36743CCFC3
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349131; cv=none; b=CtRfF88qOkxMP7VdWVb+a9FNynfhT1Pkv9QbDJI1PAUC/e6DDCZclOLRV6v/zoFtI61RrqAiW+SQ/Pzk84NDfa0+KPjsN1ORqxQfg51PnU+uLwoLNYGe6WKu1Tme9c/CFz2HxpQsHT1MCoPnP9uhuGUPnpVBiWzEFW25aZTFqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349131; c=relaxed/simple;
	bh=smAy18PTxlqKtr0fAfOQjvSthiR1gMkFArrDRBaE+8w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f0wevMLG8YNCkw7WRVQT6pyVIV4e65c9bznMLOTnhtafrhFvZudswElS3s6jxLHi+eFR5C1PPzBqSAgR1UKkCJ6OsV9NQtJl+UteXJpM6TJVJ9DfZD1Wzalvi0Q+8UhJXma342L2GJbl1Un13MepMFcfHUjsZQmByVpOc2TXcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fryhxCdq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fryhxCdq"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c79467f124dso1644166a12.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349130; x=1776953930; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4m0FAz6UNeMEXijwgItkdeyvCcIHaqfir++jBgGhak=;
        b=fryhxCdqjRcaftLUrTujK4dZQO1gPoDU2/SGTHdgY7VzrlFhoVTKQ2WaWuH1b3j0y9
         8dMAhuNIEbKG//G3cleEB/9WtFO37uXf8dhUy20svJZ29tJSLS2s3iK4d3M0CM5YEg+q
         DodDxXUoPViNJ39TowU0IiVCTxnCXgXDSlXAOkoFE0cuy37CreF50Z0pNOhmxq5ODFOf
         O8tg2gddQgUPTXykgRvp2sbG7rasqfgcL0VBXhqSMx5trWZ1pUoqg8uy1gM7ASg2VsMM
         usCAWMKRLJSqDx0r3bJf3NmLmNRZ/f9UQcasg+UjRD3GywJe0lydj9m8Gk5SYrJYJsrZ
         g2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349130; x=1776953930;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4m0FAz6UNeMEXijwgItkdeyvCcIHaqfir++jBgGhak=;
        b=cHnsFLeExDnwpOBWpVqzYI90xR5tUjxTg+uMF7aXMD2r3L3B6GqqBEiwohPcxw812j
         R4LxEidHDE2BxYrsbj0akN35YqLBuRuv9RyTIzo4Nwy9+l9eGkpTUVFwi0ma1Pb7hQ/9
         +67unqp51c7jevL2oDFB7lonF/FnSmvwU1ZqJ39pTHUQZT1mChMnOQQ/BqmzQbzkfxCu
         XXC0bu545VWTt/7EOCmonTj4iNb003K4StUFir0MVzR3lsN4SlMKH8bxJ7BpB+96J0Q5
         cr4bvAnLTdOacAI+TiD8GOm6LKmVnovsMo6U0/XwL5oXD1VHlju+hLgJdfYw+F0T1Ghi
         1yaw==
X-Gm-Message-State: AOJu0Yy3D0sNS9RHOWlvBNAx9WY8ooOHI3w1MuIVj/AGz1I5FfS6G5H/
	ZIVvjZz8y1XUzXuWSMK8PWgy2BMH4bllgJjjGdbGFg10BZ1SahRZcHjg
X-Gm-Gg: AeBDievfCO9ZLoaAB2ClBasa0ugkPGrSyqoJWvEV8C9FDpULidextn6LllHoz2lxoEe
	RDhPo2xbwrRtDIjiwyQ/tvFQ1SM5FHAhbZAhvoQClUU0r0TQnVI5l5bAsUaXrv2BhDJl1npdRMI
	Jxkwq0+CDmpr8jkR3GeqNtuONBtcpk6CTCFk3Q8vPk+VoavidccAprJDx0RSK+uMOlZ6P/li5zI
	LYgFXP78gkwocudEOHS8F+WrhRnnIRbWvaQ2V/JTDq+3dy/pT0eoYeT44kYpbnGikYgS6LQ0cEH
	6O9hyQ39G6kvH8dQAr8EAwtfV5k6Ql+tj4kJ5stryRUcnhg4UMBzrvULAKAV4fscbAQyQVcsuG8
	vfpfBA92GtsKJ89iOKH+wiBWl17u18AqcdI7ChdiZJL7xHwVgMDYusSsxN3yWg21AqYQMzIRLPD
	jANM1/TL2tTAelRdqCF8uvON4GBphmdIcvl2GGIY43HBbq5A8LpYZU09LNrzbxPx9eKMk6h2teu
	U/lqZzqncrDNNmMP55xGxXYlKCR2QM8oFf4xZmEwZEZCgL1xQpg/bCrvJfw2MxyFJo=
X-Received: by 2002:a05:6a20:12d2:b0:398:9ae9:710f with SMTP id adf61e73a8af0-39fe3d53b21mr28501431637.13.1776349129943;
        Thu, 16 Apr 2026 07:18:49 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79581a31a8sm4408141a12.18.2026.04.16.07.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 07:18:48 -0700
Message-Id: <DHUN7O2WOLPC.107WH88I4E15I@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: name the enum for
 BPF_FUNC_skb_adjust_room flags
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko@lists.linux.dev>, "Nick Hudson" <nhudson@akamai.com>
X-Mailer: aerc 0.21.0
References: <20260416075514.927101-2-nhudson@akamai.com>
 <20260416100225.178D6C2BCAF@smtp.kernel.org>
In-Reply-To: <20260416100225.178D6C2BCAF@smtp.kernel.org>

On Thu Apr 16, 2026 at 3:02 AM PDT, sashiko-bot wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The newly named `enum bpf_adj_room_flags` will not be emitted =
into the kernel's BTF, rendering the intended CO-RE lookups non-functional.
> --
>
> commit d9be60117de7ebbae2642c8a29e31a5aa11ff502
> Author: Nick Hudson <nhudson@akamai.com>
>
> bpf: name the enum for BPF_FUNC_skb_adjust_room flags
>
> This commit names the previously anonymous enum for BPF_FUNC_skb_adjust_r=
oom
> flags to bpf_adj_room_flags. The stated goal is to enable CO-RE lookups i=
n
> BPF programs.
>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c8d400b7680a8..bc4b25eb72ce5 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -6209,7 +6209,7 @@ enum {
>>  };
>> =20
>>  /* BPF_FUNC_skb_adjust_room flags. */
>> -enum {
>> +enum bpf_adj_room_flags {
>
> Since this enum is only declared in the UAPI header and never actually us=
ed as
> a variable, parameter, or struct field type in the kernel C code, will th=
e
> compiler generate DWARF debug information for it?
>
> If it is omitted from the DWARF info, pahole will not emit it into the
> vmlinux BTF. This causes libbpf CO-RE checks for these values to silently
> evaluate to false regardless of the kernel version, which seems to defeat=
 the
> purpose of this patch.
>
> Does the kernel need to explicitly force the emission of this type into t=
he
> target BTF, for example by using BTF_TYPE_EMIT(enum bpf_adj_room_flags) i=
n a
> compiled C file?

Nick,

take bots feedback with a grain of salt.
I suspect the bot is wrong here, but do you homework.

