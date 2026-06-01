Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FD9463
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780290198; cv=none; b=PV/9WWlAa28iP8naiXIVG9FYMQNYJcON3YEB8AcQHlHsyfHU0Fwp/gdezECS4Jt7qRuBp90l5pNcRyD+oIoNT7xW1AJQv1D6RRA7GeuFmSMePAMXwWTSrp1/fhIKkzA0MmUq9PhaGrpNSuvuL6X9TpyzPd/e+rd80lmoqhLAzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780290198; c=relaxed/simple;
	bh=2+uyhBQagbfG5ZCWG5OKDBtrcFUr3emz6OXagiQU61s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a8/dlnEkDb4DdCGeIYlbVAT3zfVL3Mp3Yvxfb17F3iTQ1nkeYeMiFlyuedYgIrN90neKDOrSXIkpXGqnVj96rznpzJlqN5vFHoxU124e/2zryZk5Oo5XFi5taL9R1LFcL14lTriew+6ThoHL2bV2UuxwV0zKdOgEnSgWbkeSUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZWaIA6zd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZWaIA6zd"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36c68964315so800800a91.2
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780290196; x=1780894996; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Sz5ZtK6XA9gIDZiiscXeLXvS4nQonpQUUo02wHj6Ok=;
        b=ZWaIA6zd++vWBsBSzmgMXgEBSoEEEJgAA/Xt9lYvZ8I75AG7Az4eCzhGATZ66cZ9WQ
         H9zSOpmgq79FicQuVXiC0SXvhVAr2H60RjR8bncwuZmhbPrMfhbnUZzW2ybrcQLqdwPf
         2fZRH0mP1axzl22RABYkoSpxGUTtPcaPUWUwm4DKbedtvFr3sngpjFamP4FgUqIJLA/n
         1Hta2ahONvKnEwWl4IcUV01u2ei1TYXbiAneRrngOzpdyZtw9A7eNI/0HiTzMTaqCw/c
         5nFd7qIbiwz8fLRoX+w9wI5kxyusaLuQe8oiuSrzoDVOZTQNoMiUu3THymsNLzOhtqPq
         AdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780290196; x=1780894996;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Sz5ZtK6XA9gIDZiiscXeLXvS4nQonpQUUo02wHj6Ok=;
        b=Cxo7cQitu37Z9/AFPhtUB83YsxHN9BS9IH8YzOCPefPptO0SbyKRtbTo/OgKBR9OaG
         04J8qw25ehSmwa0TY/hT3AcMkDhBVdmWBWVM0oi/jbpSb+6QP2jhK5R3InyiTuB4nDZU
         PXXPU6KE+hCaExEgzgD1STFBnhXf2pGALrpbOWDNOEczuH4JLoqODJfMdIWoTvsutd6B
         qV6hp64aReNduTdr9zXgNIoQ/x0apkaLT525JbR/2z1kjkBhy7W22jdBxMOSWyVPoRuG
         LfpvsHCBRYl6VHXoKMpBn0wtLwurAzhg4+Tb6NyluJ4TEqa4SSnuwotB5ORxMwhQq0sY
         GSOA==
X-Gm-Message-State: AOJu0YyMdOWmsUNdYAvORb2+gP5UCNtdpWwrYOFBS6Hzl8eHT1RSqcDD
	cRcNGzpWNj8tHmXr61JnIOQ2cJRhzsZqR9Y/znQcaCgLIumktJSvR24GcPqcIQH1LVA=
X-Gm-Gg: Acq92OEa9CrUwbvMXQf3SRejEeBif4K/aVlpIv6Fnc7sqWSTpIPv1nJYXahsB2u2U8n
	XtZvl3jYo4Pa3oz9gTSkaJwrn7wtgDNwBqLn6YFGTwhkJhJrSp7DvcQ1WAWK4GdMdU70qMhbdv5
	JJ0aCKPezaY9/0xAgm7ts+c2lIv2fXV/GYOnmAO+D2lr/XJQ3sj6rctX7X84BS2r+pYuQ5eXKuI
	XmxXZlMYkupZbzP7z3IP188q0YPpK/43iWI5i/Zdv9tBSeezv7++mZIYym9ox9/GW/+bjfiyJAr
	PLJ47Z2jWidFsIBdY131cbVy+C3b9KCYA9l+p99F5NLYBN93HiNclBRruEKbB21EFrszC3Wrp9O
	+TSugiDN3978KsRpDXQfPSanrIDrDxvKdawlIfP+WY29s2rarX+QT7TGxr50FmhOy6C3HBBM3gL
	RdAn2N6Cevv7myVPTHvYNTxZOqbgG3R+IGRzQ=
X-Received: by 2002:a17:90b:5289:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-36c4ff25c56mr8168205a91.4.1780290195983;
        Sun, 31 May 2026 22:03:15 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdcf4773sm4250439a91.5.2026.05.31.22.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 01:03:14 -0400
Message-Id: <DIXG7CV6I2RL.2D0BT0TKB2ZM9@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Remove __arg_arena from
 the codebase
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260530002259.4505-5-emil@etsalapatis.com>
 <20260530050310.113761F00893@smtp.kernel.org>
 <DIWLWEKAUX29.3HJP2JO064JLR@gmail.com>
In-Reply-To: <DIWLWEKAUX29.3HJP2JO064JLR@gmail.com>

On Sun May 31, 2026 at 1:18 AM EDT, Alexei Starovoitov wrote:
> On Fri May 29, 2026 at 10:03 PM PDT, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [Low] Incomplete removal of `__arg_arena` annotation
>> --
>>
>> commit 936642e9509313ae2959c6a3c4255651cca7040f
>> Author: Emil Tsalapatis <emil@etsalapatis.com>
>>
>> selftests/bpf: Remove __arg_arena from the codebase
>>
>> This commit removes the __arg_arena annotation from the codebase because
>> it has been subsumed by the __arena BTF type tag. The typedefs previousl=
y
>> used to minimize __arena annotations are removed, and the pointer types
>> are directly annotated when declaring variables instead.
>>
>>> diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testi=
ng/selftests/bpf/bpf_arena_htab.h
>>> index acc01a876668e..eb80d67c38708 100644
>>> --- a/tools/testing/selftests/bpf/bpf_arena_htab.h
>>> +++ b/tools/testing/selftests/bpf/bpf_arena_htab.h
>>
>> [ ... ]
>>
>>> @@ -53,7 +52,7 @@ static int htab_hash(int key)
>>>  	return key;
>>>  }
>>> =20
>>> -__weak int htab_lookup_elem(htab_t *htab __arg_arena, int key)
>>> +__weak int htab_lookup_elem(struct htab __arena *htab __arg_arena, int=
 key)
>>
>> [Severity: Low]
>> Is the __arg_arena annotation incorrectly retained here? The commit
>> message mentions removing __arg_arena from the codebase, but it seems to
>> still be present in the signature of htab_lookup_elem().
>
> Spotted this manually as well.

Valid issue, this use was originally left in because arena_htab has a
selftests for FORCE_ASM mode that turns the __arena into a no-op. I will
make sure __arena retains the type tag even with that option on, which
should make the test pass.
