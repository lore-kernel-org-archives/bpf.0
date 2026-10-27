Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136152;
	b=XT0dDKSA3L3RPH3UoPPiq7IBR3XytXpKUaS9A71oo5SmpKpCc4Z2gQiDbfPpxl+Z7sqr
	 IkweXsiddM8QOhpRT/M36G+G+3BESLWoj9BY1pKxZJlASigxGoPyFJJAkOmaC5UWp0Wey
	 Q2hpifyhE++Mgksz4GL/g1R1wwe5umF/EJriHxr8ZjBKXtuUudoDjOvTvjvcEfWCvrgdU
	 Qy2NWQuW8+s8VokNiron/opR+CNGpiiWO7ZAabHOy0VCmlN3GKH8BAwmRbsOdd7Ngss4A
	 16MexxWdmulHqTN2eUHEqof4vhQb3/y25y7+V4awh4ATbLk048mpLgM8Wa8FHNBmkhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=DdmGG1HqM1PrftPT1v5usIleZje7u24hkEuDG1qQe/Y=;
	b=M0sgFyjguhMb3EPg0oKH6U4n/Z6CgXQCnVTIBtEFPCjGv+bPKl32VBzEIVTTgWsTLM2H
	 k7lIvONhJ2Zca2cQvnkv2qiWNdDoZjjPCTKN2RWjrNY3roflcK1G6cAxTIgFIvcb6xiE8
	 xFIPcH9nLbz+899beI7i0r06sniFDsYdVk0mp5GQJzNi/6zKsatMakLedLVWISymYUM5C
	 7O+teUCywL0EOg7TlzPDLQSiFF/ZwyET0bBpnut8oJJA/bgdEvWZcOkaHoYP6RMc0teZk
	 LWUjT6XfjLxss3VVp7nWsRUdcuQCR/PEahG8fpy/DCA7/n8sGqaJYU9PDWkPmsW47nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7FLJZLy;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76D606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF76D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7FLJZLy
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e946155442so1912755ad.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136151; x=1793740951; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdmGG1HqM1PrftPT1v5usIleZje7u24hkEuDG1qQe/Y=;
        b=O7FLJZLy6wv6WEE7YudMbN3WMx8fyggXGDdjgsdHGlGXSjG1PrrGhLZrkyaNUH/FH5
         WoAFpOSP3oqDUwnS+gr7Cm9suWoP5erqiX/7+5TKlbL+tvJgkDsTHH5SNZDF/QjOlmTf
         oki14SZe42cilUbUi2uaEsh1JFlwdsyPu6phAxhscFQPs+FGcRrireUIJulX/Ialtnq6
         VJO7kXfsKRj9ahLiAn059FvQxxjcoOHaTon0o+ZEn8ER4scJpb1KS26JM6oTXtwiK+F2
         q+upbiwwqZJSZICCarIuFDQSOP6z1RPNk36TQPHa8p8actD3oLOFPPGvaeLytlvbvUdj
         hscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136151; x=1793740951;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdmGG1HqM1PrftPT1v5usIleZje7u24hkEuDG1qQe/Y=;
        b=U6JnutGh7WmTAtxRjELWp5ozbPJ+gYLJ8LmAkkjmLi2b2QUTCety7Bxj733ru7wb+g
         UWOglaMfMvYR4ky9Ce5vmzu9CDAhGV8+SZqmvbVffBaK8ju/CcZAg0Wd2Qi5h1wixAfb
         csqIobmVvr1AY2iCb6yQdg4gQrnmExWQSySMdWtUgfwUB6fYavP2PeBPkKzfnG28jNAq
         umcBYmVG5jqPSb5uU0KWsJeu0m04LoZOa6HYrBjg8XMPFFcbubsW43TBcEmNEorEQTjb
         XvQ/aM0FdeyjFHuK2xsMBO5gHxWMoBm8gTp5Ira5GpqJjZx+RsDXrrf5Xd9foo0cl0xN
         aneA==
X-Forwarded-Encrypted: i=1; AKwUvBwzeyDWd3tJ6PRuB96pepgmwfW5L0PL0WHucg4HX8nt6w8N4KtV2ANv4465Jpv9vrIs9R8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwucDUe1D/fuoTLW++PiPMi/BArrCzbSqrkHCCE0+s0c6MIVbj
	B8fV50gRWTzNIhlK4pI0OLpQp+4ftLiQc0k4vdTXXZHk53qd6Hl0B9lE
X-Gm-Gg: AYBFou2wolmRKVsufWA4O7lAlBRgpeGwsI5HXHRUPS/RDhYpZrT9zTIaI4AB0lEpHWB
	PdJDs1fHDzC91IRRX4st/q8lWUc+B08OhGvmYJqPQPefEMvrpWAibErTaM+kAerpie30E453gcU
	EwTdUnHqZdHpVmUrH389HyVWswgbRYVPMrJjbf2Cf0duQeXsIls02VkZ7xU9wjGYGf9m6DwXsT7
	j4SwbKa2vwNH1XVZ/kJMJ4yE4vkfo8KZzK8DqrbpJB2p85cltgYAWJXo6Rq2kZAIeTTeFCzKPNp
	JhrgXoac2TvZhHfsgRqJG2YcpOsmIspN9eXh3HG3VbxLh8RtcFxbbhzDUOnDlcmlusQ109DAX69
	TF/v4yzvA0GtOBpxfYAVnKUs+6T7p8FxFzkxEU15ECBtSvXF5ka016QdyaZaLagARKyW0Js3XPy
	OLnqbcpcoTpm8Pg2iWwkrg24k5jGy+UezaSJ9w0Ypm/CyEdQ9T0m5RLEdpj91YzQzqm2/AAhT/T
	wq/nyw+05NsX86TXofsDlkRxuy3DljNCl3oz4AQ170fiZDzpaYNHfVe66l6xWLIA2OJrA5MwgXN
	UhY96Zg0r0/iPCm1OXjMZzAihjYN5Z0+vFBg0svrZjfuGleKPQ9F+zuUYJff
X-Received: by 2002:a17:903:b4c:b0:2dd:ad73:c938 with SMTP id d9443c01a7336-2eb004fc178mr5234955ad.25.1793136150858;
        Tue, 27 Oct 2026 14:22:30 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6454a37sm14851685ad.3.2026.10.27.14.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:22:30 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 21:22:30 +0000
Message-Id: <DMFXPRARP7T8.JRCWN1DA8NWL@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries
 is not set
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <CAP01T75GQRJWXWVNhxxYH6w21QfFVvi_eBV-ob0uEHLmx4DQrg@mail.gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-17-alexei.starovoitov@gmail.com> <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com> <CAP01T775XCUmtK97tBcWsvOvUsGxR7AKCGqfOCgebf+-_WfhkQ@mail.gmail.com> <DMF6PRBIH8GS.3LZZSW3LDCMWQ@gmail.com> <CAP01T75GQRJWXWVNhxxYH6w21QfFVvi_eBV-ob0uEHLmx4DQrg@mail.gmail.com>
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

On Tue, Oct 27, 2026 at 02:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> The reason I didn't go with 4G since 4k pages on x86 need 8Mbyte
>> of kernel memory for empty arena while 1G needs 2Mbyte, which felt ok-ish.
>
> I re-read the current code (even with your patches in this set), my
> understanding is that regardless of max_entries, we always commit 8MB
> of page tables, no? I don't see anything that uses max_entries to
> decide that bit. So I think this patch is noop regardless.

ohh. populate_pgtable_except_pte() doesn't look at max_entries :(
sigh. ok let's do 4G then.
The only remaining question is whether to do it libbpf or kernel.
I lean toward libbpf, since it's easier to revisit
if/when we fix populate_pgtable_except_pte() not to waste memory.
