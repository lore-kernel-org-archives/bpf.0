Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CCE306B3D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077356; cv=none; b=TyStN52SYKrqangAcnOWx4gw4N51ydlmXlwub7WCWEXszrHFqfatt0SIty+RVNl7/67CX/csPPeLEJuAwxOajSrdQfNTAWh+5EK+pi8R9+gILeBccB3Zs50s+Nm66NrXFUNTPm6A6Klr4OobUnvXfckkodvMTw70aSXGfn+qw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077356; c=relaxed/simple;
	bh=8ObtmiXxUW0QYBKwMksxElhRQHOEDgL0OR2XCBFcIxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=T9EXPE9oxXl+rPnA3eyp1AACM/t5yZ9WzzcMw4QDjJwdazsgiFy7nxO7mxIwsbaMa6Ts2P0ODNfrsJK8FOilx1Aptl3euWl0xV8gHiXr4uj0537E4fk98++Gkg+4xwWdRXdsbhS1vOW/I+vStw3YkfbemfV2T0ExfkbK0asvNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=wsNMLSfs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="wsNMLSfs"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2acc1e170cso924334666b.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792077353; x=1792682153; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1fIDtIhk7OY8zkMZnxFxkhA3Vz85iLRRDcbIuJn6NY=;
        b=wsNMLSfsCUwhN/WPuuLsbcjhJjC/20n3JW5T4OjGRhDghl3PoKpmPtbjvsu752tFEs
         5anqEZYsfQ3IejuXIex6n/uiw55GaI5iyiLaCFE3eiE3q/baWdXOwzZ3PIPpblrhZ8Wh
         me7KSAPrk2DKuMTB/cxsPZ3QzP68WTb7WyMpB5pSgL4WVURgDHreVYwptSiO9bPgTXSX
         GCinhFiqXf210Z/kdaJQqMSh340MaFLsHOfbzl/mMnsUM3oS35j+KJaQ74z6/Bq0g4No
         u3F/lO0jRIhzvLDocfDAJJ3gFMnWAg9hNJ21dTZWUsRns9UpfrtVwBWr71f7UOPqIdVL
         k2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077353; x=1792682153;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/1fIDtIhk7OY8zkMZnxFxkhA3Vz85iLRRDcbIuJn6NY=;
        b=HWF3+ydYURpkw9vZIynEGRDTfaxmtUs7DhTnVIRWa7qhlGaylQTI/lYuCnKwF2fIrY
         FWT+lBomnOn+QjcfzvCjBFcjyo2dDu9c2AIi1AqCfsQuQGjW3GUuQSaq6jhak0OicLjB
         bjI3Z9/MTtFcfinTo44dib+7lwuLPdj0vlnDsjMalae04sKSuX7jMO4wCSJxq/F7TBGJ
         5r+U022C/szy70QktowLM6bOhCKFxQqlj5lVCyV36k9UUnZg2eX6cW3P14mBcFHf0Yq/
         mk36wmXxp6Lvw2WLl0uP3OrHbEzVBpHZ5TAusFc3lrERV0tIoX1HGtj+YFbowy93WNkO
         T1tQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDdqAZKpoULMrbwQl+I5kMOytv2fmVDeiGDqEMEAGTBMJRU47PYZk3BAoV6otye4sGzFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq5lF00MHouwbTn+HYksNSK59FM044d4KYwwOxvUTMFZ6o8dPN
	XEWnfsAYYZqJU4GPIrhJOmMSo9COIe6kOhcRAia0qoGwV4w3iAndGEtNqyJQtctACmkM8ZG+yt8
	UyVaUN4vpsA==
X-Gm-Gg: AYBFou020WnJh2B2vr/4DlSk+Q3KkPttjrwZKCCq13hu7Pu68J3ql+uWUJqjDOqA5Ea
	3HOILsBFst4BZlpcpzrWpOs8M/fShSEtqr+j6MwV7kbuoH297Qg5ym8Tp0QFooLaxOhAKmgkw/e
	y5e1B7tROo8uv9nDmdZGwnMLKneubN/wKiZZj16v/SWDKb2ykzFybFt1az6uV7mdzqHCKMsE/Il
	7/bxiTRgnmQsdC388VbPm/Ng8MsxGJmimFyMoWqNiuKvR6msB31TxGnCTSJDAosIo6nM4aof3p6
	7VvmAMAmF72LupSrkAYorgiWmmdtv+GFgzjgRZnCIu0Qfm4FpKiQDxiCHRSONGBRnGqMSaeMrvU
	23uZqjQhYJhh1b8mG+NUmLPol86YMFmsi85BWWjBMAE2n5B2i+DW1JVb/STpA+xAi+O1lUnmdNV
	FN+NI6dSosxIUWZuFgsCdUaUic1aE5e0YdAwrsdPojTcjN37CsAdY=
X-Received: by 2002:a17:906:7948:b0:c2e:7fe7:288e with SMTP id a640c23a62f3a-c31aa082a00mr1715848566b.32.1792077352413;
        Thu, 15 Oct 2026 08:15:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed2e822f6sm144542566b.0.2026.10.15.08.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 15:15:40 +0000
Message-Id: <DM5IECVK7EOP.2BSY4WBREGEA8@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Associate arena pages with their
 mapping
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-1-emil@etsalapatis.com>
 <20261014233442.8392-3-emil@etsalapatis.com>
 <sashiko-outbox-172042@kernel.org>
In-Reply-To: <sashiko-outbox-172042@kernel.org>

qn Thu Oct 15, 2026 at 12:01 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: sleeping lock_page() called under PTL spinlock in existing_=
page_cb()
> --
>
> commit 06bc77555d3cf904ccf154edab307819785c3c2b
> Author: Emil Tsalapatis <emil@etsalapatis.com>
> Subject: bpf: Associate arena pages with their mapping
>
> This commit associates arena backing pages with the arena's private mappi=
ng
> and sets their page offsets. This allows the fault handler to delegate us=
er
> PTE installation to generic MM code, helping avoid races with kfunc-relat=
ed
> arena operations.
>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index b95ffdb14417a..650baa09fcb5a 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
> [ ... ]
>> @@ -355,6 +371,14 @@ static struct bpf_map *arena_map_alloc(union bpf_at=
tr *attr)
>>  	return ERR_PTR(err);
>>  }
>> =20
>> +static void arena_put_page(struct page *page)
>> +{
>> +	lock_page(page);
>> +	page->mapping =3D NULL;
>> +	unlock_page(page);
>> +	__free_page(page);
>> +}
>> +
>>  static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data=
)
>>  {
>>  	struct bpf_arena *arena =3D data;
>> @@ -378,7 +402,7 @@ static int existing_page_cb(pte_t *ptep, unsigned lo=
ng addr, void *data)
>>  	 * the TLB entries can stick around and continue to permit access to
>>  	 * the freed page. So it all relies on 1.
>>  	 */
>> -	__free_page(page);
>> +	arena_put_page(page);
>
> [Severity: High]
> Does this code call a sleepable function under a spinlock?
>
> existing_page_cb() is passed as a callback to apply_to_existing_page_rang=
e()
> during map destruction. The MM core function apply_to_pte_range() acquire=
s
> the Page Table Lock (PTL) spinlock via pte_offset_map_lock() before
> iterating over PTEs and invoking the callback.
>
> The new arena_put_page() function calls lock_page(), which contains a
> might_sleep() check and waits on a bitlock that can sleep.
>
> Sleeping while holding the PTL spinlock will lead to a 'scheduling while
> atomic' panic or deadlock.
>

We always call apply_to_existing_page_range() with init_mm, so there's no P=
TL
taken. That being said, the call is made with lazy MMU mode enabled that re=
quires
us not to sleep. We can collect the pages during the page table walk, remov=
e the
kernel mapping, and then free the pages outside of the callback where we ca=
n take
the lock. We pretty much already do that everywhere else apart from arena_m=
ap_free
anyway.

>>  	return 0;
>>  }

