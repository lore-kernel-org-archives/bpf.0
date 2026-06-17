Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596801DA23
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781659187; cv=none; b=p7sZZsXfuruHvSyjhlVqdlPLq5dmyL01RGkgjS1jgM4i6Sk1WrkduyQKMnxUA+d6luwU84TpF93ipSZvS5HwYBEkRXUE2YFwS5WBACSaN8BSWvk8fCrW630EvmPj9MtLpb5Ys9loKpU7QLXUl9ftL+DcKe72kT3/dhy4soY1SbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781659187; c=relaxed/simple;
	bh=sTH9HHQl0lFCgAsKzg6XHuSikL70DNcqx6O4LDhhPHQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nox3Ne3x/sf+amcozrY27nIp5o5kxRaCSclawOtxATQCvXF0uSK+kwOp6D83L52vl3jUbMH4M6+UB0em/pe4gpbxfKG08JZQf8YwhNPOJMVfWoh90kcN+qcnPv8PDyB0WMWLSOJozyAhdhbu1VDHCpJPRwtgHtewE/PbpM/azWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uZn3OZvd; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uZn3OZvd"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30759632453so8195538eec.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 18:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781659185; x=1782263985; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUoFwkrunjip/o5mE9aOfiRs/1adrK0vkFTMn8eCPxk=;
        b=uZn3OZvdPJOCODMsMe7oRfQ820/hVgJEsjDDbeDGVU2fuF0Ey8/XzDoNt7rtKqu8W5
         5CMI4FTkprYsc85KuJblNWRlpRDXhW5xQoBFEukG+PV3Is88ae/Qk3I6lUxjxeDYZKBh
         X/irsOuP2oAzNbCsSz1YcKW5lf3qUF+5AVcsdf4+Zul/R9tf5PKAN4d1Y8l3ZNfxu66V
         mkumoyjnvZwkWhaC6lManzHJKt/+4S4ir5ZMmLz277chfyoZvY78EuVsdENvnPjhOCq9
         n20P8ouulSltrfAtCBgoZCya2RQvRUT/Tkn4+OfmGO/cwompqrCk3bK/pYf5aVMW1Lwf
         PkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781659185; x=1782263985;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUoFwkrunjip/o5mE9aOfiRs/1adrK0vkFTMn8eCPxk=;
        b=jTKWopsqDt+1kQcPWNL4az8/W8VI2JVfVdUQL95/4VQsYmYMkkfUS1v/ytPkRfWPF9
         5UPXgks8MPq6EtI25SkJUG75Kq863gmOhgx/oi1JGtUBtHPw2m/Zba5KupBte6w4JaWB
         JfFxc6x7kfxj01BAcP+6iZcIDJDZiZHh42MFw+g9id0ioQ1rVlEIs6HTFhVy9XbbQxGN
         MvEDgbnxlA1DlMQexy51qbAniEch5g9d+L8exAISzF/N04vX+sR4k67t0qOKShm+SWKq
         qELw20tcpf3jkMPyr/jP1LLvHPvgIdxjUqaPeDuTfu40u8n8BVlZ1F2+0IUMkVH077pK
         uQgw==
X-Gm-Message-State: AOJu0YztQadhAKbrpe5FbunjLFdPhgTJBvcUuwEFSZgWg2wSK1qjOIGV
	3zUB7xb4dKhoQVWpGTdTnk8qcWK2JZ3CeGGIEZaOu3tdoKJCVoyqmZHzw3hJrp3Ncug=
X-Gm-Gg: AfdE7cneQy4d+V5aBG0LPdMrtYmjRyRSTFYG4m4+EZXQwsA0RcOA9qR564Gzr3Ld3au
	i4StZ9lrOyJQgBRFb/8QhXdpbUOSDkGvHxiwqlJNMdbZd6lqq3o70KfhegJ4cMbI+YSDxQc5XMG
	TDwVgnyxk18V+Sg/OAZw9RxfECcBrf2IqF8OEs9tjxfIffm4wAdPPct0lFCAvxL6X8Z8QryAfS5
	1FaZ82lCL3yvOESpPbkz2Qh+ENcrWB48sW2oGEyMXgR7BXB2nZgjLp6tFPO2dltFe0BhKmDkoON
	XIz9w3xYZiPYddIoIy6AM++bgm8QLDLnlMEuftRcFrvOzNRm0hDqVtGdiS+TKY/fbX/fb+HVqhU
	dShY/ldAm1QhDL5H8PaxLUcTeaLAJmdjMp/+nhbo6EDcZBHrS+MO0VtCk4yw1Dqre21x4e1BWp/
	Ql5efh
X-Received: by 2002:a05:693c:20d0:10b0:30b:d344:abcf with SMTP id 5a478bee46e88-30bd344ac71mr211732eec.5.1781659185280;
        Tue, 16 Jun 2026 18:19:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2568])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm21540878eec.3.2026.06.16.18.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 18:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 21:19:43 -0400
Message-Id: <DJAXGXLF4NHZ.17HAW2R1YDK7I@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 3/6] libbpf: ringbuf: Handle position counter wrap
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Tamir Duberstein"
 <tamird@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260613-bpf-ringbuf-fixes-v1-3-e623481cb724@kernel.org>
 <20260614020552.022A11F000E9@smtp.kernel.org>
In-Reply-To: <20260614020552.022A11F000E9@smtp.kernel.org>

On Sat Jun 13, 2026 at 10:05 PM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] `__bpf_ringbuf_reserve` in the kernel permanently fails allocati=
ons after 32-bit position wrap-around.
> - [High] Kernel-side `__bpf_user_ringbuf_peek` incorrectly handles 32-bit=
 wrap-around, leading to permanent stalls and bypassing bounds checks.
> - [High] 32-bit userspace running on a 64-bit kernel permanently breaks B=
PF ring buffers after 4GB of data is processed due to pointer size mismatch=
es.
> --
>
> commit ce5e8d811804f9ff598195a7f394512f77c373b0
> Author: Tamir Duberstein <tamird@kernel.org>
>
> libbpf: ringbuf: Handle position counter wrap
>
> Ring buffer positions are unsigned long counters and can wrap on 32-bit
> systems. ringbuf_process_ring() stops consuming when producer_pos wraps
> below consumer_pos because it compares the counters by magnitude.
>
>> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
>> index ae7fa79b62170..b7adce37b5196 100644
>> --- a/tools/lib/bpf/ringbuf.c
>> +++ b/tools/lib/bpf/ringbuf.c
>> @@ -268,7 +268,7 @@ static int64_t ringbuf_process_ring(struct ring *r, =
size_t n)
>>  	do {
>>  		got_new_data =3D false;
>>  		prod_pos =3D smp_load_acquire(r->producer_pos);
>> -		while (cons_pos < prod_pos) {
>> +		while (cons_pos !=3D prod_pos) {
>>  			len_ptr =3D r->data + (cons_pos & r->mask);
>>  			len =3D smp_load_acquire(len_ptr);
>>=20
>
<SNIP>
>
> [Severity: High]
> This is a pre-existing issue, but does the kernel side have a similar
> wrap-around issue in __bpf_ringbuf_reserve()?
>
> kernel/bpf/ringbuf.c:__bpf_ringbuf_reserve() {
>     ...
>     while (pend_pos < prod_pos) {
>         ...
>     }
>     ...
> }
>
> Since pend_pos and prod_pos are unsigned longs, on 32-bit kernels, does
> this magnitude comparison fail when producer_pos wraps around to a small
> value? It appears pend_pos would freeze at its pre-wrap value, causing
> bpf_ringbuf_has_space() to permanently return false and deny future
> allocations.

This seems like a fair point, if we're going to modify one let's also
modify the other. Wrt the "32-bit binaries on 64-bit" Sashiko warnings
they're a bridge too far, we have to draw the line somewhere.

Can we also add a comment as to why we're using !=3D in both locations?

<SNIP>
