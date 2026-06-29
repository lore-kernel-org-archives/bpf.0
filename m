Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850D428837
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745717; cv=none; b=JJ4M3MNFjHtfx35j1arxMK0T11aVGOgtpCgQVs6fB+YeduZ2TBb1NIENA3YyBmRRjKUWOVX86pPTZ+r0Dp9QLFAz3fF76CwA8ahn81znQKKlmQ11jx2q3nuhE1qozMXuTLINsvwuBpCjhNQhfsb9qrKJc+irK+jYYWyRNKyLDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745717; c=relaxed/simple;
	bh=lMco64SlCp2iFk0E6dTwrSjmt/kwqJaHvhyZAbJrpBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lWToHzRNvBq2Rj2GJlcDr9/03TMj1Nd0MEhuRGiX1+cZ9pl9EraaQBeUygUsvC0+CQ4CUag7BiAxM+TRAFpncEI4RksZPMgXWPLDBwEVvb3xBsZYfiHmIL2tKwal9Eugnet19bYUq3cprx79ijArJxjf+MZ1DuhUZnG2VHoONiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5ZbIrUt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s4+DPnR8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5ZbIrUt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s4+DPnR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782745713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HnLlIWAqKGkYvHzL3qLHQR1QHqWY2RRH9mZcPadrEj8=;
	b=b5ZbIrUtJ2KPwudBIEZBC+5T1uJzJV6MXH0jNRtzanYo17gfx1U1molluh9joC2z87eE2s
	aAYoxC2kalUKGhUIpnNdnFcRfMMw3cgDTollCteWnE/qxSmKn0feKkLP/VhAXhw9kZCY/4
	P1Zz2gM08ndW8sM37VMzL2rQcEe24hQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-AwmUMiojPPyWRxeDtDyTZw-1; Mon, 29 Jun 2026 11:08:31 -0400
X-MC-Unique: AwmUMiojPPyWRxeDtDyTZw-1
X-Mimecast-MFC-AGG-ID: AwmUMiojPPyWRxeDtDyTZw_1782745711
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1276292eb9so68005866b.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782745710; x=1783350510; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnLlIWAqKGkYvHzL3qLHQR1QHqWY2RRH9mZcPadrEj8=;
        b=s4+DPnR83b0302ZQ/XbDG9FJWKm66/FR0E2Tlg9H3b/w4BTuI2Frim1fxSaFIG8ztP
         smo+AVNGR2y9gq2sZJHoFVpRho5ocPMZPsmJwGD+xNvT806U8gZSwZr6ZYH4GHstRyi5
         4TeBlPCHo6UuCveZkGsP1lNtqaB1F6JTyptugqFfBpo4SGbb1tCm+7Hf/Tk2QWgbIH0v
         OrSyhPwG/r+Qivl5s0AvVzNIzlqwP+DnTHjCqR/ptzC8Tyovsb868vWwiO2YFNa9dlpS
         yYGzOpY/vY3O8rYWWe6kd8X3R0R4gnq6Eg9T8cJag66dYR1PPvEi+ovmv7ddEGiMk71K
         fekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745710; x=1783350510;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnLlIWAqKGkYvHzL3qLHQR1QHqWY2RRH9mZcPadrEj8=;
        b=cDYOSLRb80V4sNWPKvAPf1/kARSTwHJF8QWnvmUuB5Iw1NCshw4UCoYmUXkhWBn4El
         JnTRRIUxaiM/IQ63D+I9jd8AimS8G55v0Cajrkn/N/C7YG2cAXxRBiFjFFvfrxxhRkIn
         StQp0TCedQMSbkp7pQDdL2wCs6yzu+uV2D65bMd+T+u1rmoE9f77gQlSHIqHk7Btzr8T
         DWYs263L5zNALcCqyhOo8wKQ1k4XizyY2i7ogjMI6P1F36QTWTu4lfo0clP678KWNPwA
         i/0MzvWLMWIwBCDFCeVv0/RdNkzJbEZuu5doPUWfIRLZaY1aKLJx3y/S7VuMycsyb3ci
         Uh6w==
X-Forwarded-Encrypted: i=1; AHgh+RqwZgOEQV2mHCz6nYlZsMtO8qjKuxjdE43p8CM/j7lX/wdtFA10fAHGYufYp7cJVVe2Mfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QsQKE2sJzwrlLPKy4uaG0QUedEkIuU7oUD60a7szazxrxF2D
	jNT/yo44fM+2otQqRBZ4DOJy4CtpaEUKZpKWSSu+jUeYj+Fm1u8SimWmWoFSzh5uUtLzwQoltDp
	yYFuTYc0D5yCH8gDmY89LivhYmSyu1gLBMtn0xM5yi3aCRXofm7zTLw==
X-Gm-Gg: AfdE7ckaY+E8Ak3Tbe8BZZFe/z+8q0mZinQVCGwzrzDK4dJtv0MbearXM8imGlXwmsr
	tlZyB6E0JepEmNhWdAQZUmNuOXZeh0Q9pEc45na1bThsHmhmAJkCVrgJ9mBks0dKPl7KjJgPKSq
	2RGKdZbpRYSY9TXGsWJfvvrEsLDmNK6wMVwFFpDEubcDY108oSokbcAwi+4N6qHGqEMKHM2WhgJ
	nu5SN2ji+iw4/oNFcnGXZPk7Yxa72x8qjx7jL3HdNaDiN3T+oSM1h/asHco+k+Xi2DzgEPjZhpE
	/C6AbbwXmoJeQrBHhKEZM9AUR5RQFjdBlafNPVEwlMXXHXzeM17VK38rx5iuGpeTkzANA/oZ8nV
	1Z7xnxioK64RtgaTmzD+NbXGpbP1IscE3tDrSlg==
X-Received: by 2002:a05:6402:d0e:b0:697:f70f:8238 with SMTP id 4fb4d7f45d1cf-698774b8165mr465867a12.4.1782745710429;
        Mon, 29 Jun 2026 08:08:30 -0700 (PDT)
X-Received: by 2002:a05:6402:d0e:b0:697:f70f:8238 with SMTP id 4fb4d7f45d1cf-698774b8165mr465847a12.4.1782745709965;
        Mon, 29 Jun 2026 08:08:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69848e5ebc0sm3512223a12.3.2026.06.29.08.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:08:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 639C280A267; Mon, 29 Jun 2026 17:08:27 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Avinash Duduskar
 <avinash.duduskar@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jun 2026 17:08:27 +0200
Message-ID: <87se65bd04.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Ahern <dsahern@kernel.org> writes:

> On 6/23/26 9:05 PM, Avinash Duduskar wrote:
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 89b36de5fdbb..e00f0392e728 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3532,6 +3532,29 @@ union bpf_attr {
>>   *			Use the mark present in *params*->mark for the fib lookup.
>>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>>   *			as it only has meaning for full lookups.
>> + *		**BPF_FIB_LOOKUP_VLAN**
>
> This flag should not be needed. Patches for vlan support were never
> submitted (I have them in some old branch). Since the vlan params are
> initialized to 0, no new flag should be needed. Besides, these are
> output parameters.

There's no enforcement from the kernel side of the parameters being
zero, though? So we do need the flag for feature detection; unless we
expect applications to do that out of band? But then we'd need a
mechanism to do that which could be... the presence of the flag in the
ENUM (and thus in BTF)? :)

-Toke

