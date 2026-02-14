Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF182765F8
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771095440; cv=pass; b=lT+MMQubwr5sHwjwkcTFJXOeW+5DvfelWVfsEyN+nSvIKQkHZJgRgeFDr6RER65WXNDhB7U13E0NFXeiMswvg+9E4Z3tNfybckQ4jzo9e2oVE0jNHnqdUqvxqQsfrUlyK47ShU1FKLzLwxDBRWWg2JDMwB1deAm/6dOLQX30YoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771095440; c=relaxed/simple;
	bh=vIfLepEI+CPnCKqAN4vP/GmXxHUQ3v/RKMM4Vri69kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSXvGAr/FoPham4+3hrS6WXI4ajmQCrL5eUR4V2RCJI5GaJkbJOugUGmPi1b4MqnsscNoe48Z6a4h6iLpR/gtoaRdFyUaNXh6+4+YnKmwfhZzOechc1liOQU/HScQNPGKcoXWjtfi9aE66lr/C2pI96zJzfGd19aOxY5xYj/mxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb07cG4W; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb07cG4W"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48371bb515eso19533455e9.1
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 10:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771095438; cv=none;
        d=google.com; s=arc-20240605;
        b=QWUXeFI+Y5il4QDip+x4Y1xCaWVm/V1l5ZCS8qGwKn1RdqX+XuuUR0+OvakezsTY/M
         tVAKX1xbmOQtrVbkGfS1nf1mKTfK+3FDPxLlsDItWYrvcIuqg66flvJ2/FFs6MmfCf00
         pMQ6B4E/7vWgUBffXmSSnk49OLGNHvNqVnZ7nsMrGSDD5Z1NA1atoO61gMkG2uPRRYwk
         O6DAvg42+QmHcO4qA9gfAU3Jd3COApqnknIfspcEEp12Z5K+x0rTAzHst1f9amFC+TdX
         2VElLG3BYADKcz8ZVhTbnVOeLsVlMgOsSN+lvKmSYq1iBTijXWbAjyDXyUxCYFPAhs28
         jDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIfLepEI+CPnCKqAN4vP/GmXxHUQ3v/RKMM4Vri69kM=;
        fh=T0qSikEWR9T4ogKe5FN8tCXCfHM/78J4UBwlACUESzc=;
        b=dCDCWmrmDQjkJCedbk1rkv/gkDZtBjnEwakU8vns+SiGQ6xq1ETqGfaULz9+H9ei+1
         7u/HLDRTLtv8/u36TSMFG1/jfbEr7PWmQacLxaWjivAbRF6IUnS8CY9HnaMx9DYrwhou
         nt6EQqGDgdC5o4t8mFQ2jAW7aaYXvopLx7wbZ4KlHNwM29cqIogAw8yagBbt/wx3kufw
         AvZKJEy0Tfn6TSthozl7D/4mtOzvJrpfKrT65pvkQi7YJfWfN8pC+hWkIa6/T2WX2OZ9
         9abjEr8eDXp+145ncrlpx9yv2DmkYns8xFYd19akYufev/iZ8v0FvzBS8F6gBRWjy2ha
         uaGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771095438; x=1771700238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIfLepEI+CPnCKqAN4vP/GmXxHUQ3v/RKMM4Vri69kM=;
        b=Sb07cG4Wtf2iRUaK3nljM+C05lokgqCVPJkn9RGeUDQBf1sNX9f+jgFWl1QWjorC+c
         Vc3pv/WdUNkKRU8mmaFaSrzRlOnikLIXWRWBe9Y+UlJ6YNbcD2C6jTcOb7dIwWZa9NSw
         8yMtKDs4+oBvEQS35sV6/EAwzkxTiYn14fEpRVmwk9OwHYiJ8UCNfnI65glhqF9A5GEx
         pxp7f8YLHw6+s1yL/Q4aVAnHSvbO4LdSjHbR4pfO6Rvk4L7Qxa+g8jM5vhf2cH/drIXL
         SR1SmO2cdmhVKJhmx7/u8SNU8+usYJHUJaWxEJopkkaGzWqYx6NYsVnoG2DQBIlcSd5a
         6JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771095438; x=1771700238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIfLepEI+CPnCKqAN4vP/GmXxHUQ3v/RKMM4Vri69kM=;
        b=oWjkUdqLJWrN4W3LvyvX4fksSHrBoNv0nnHjuTuNtYj3kyBQdvZhG+fnYp8SpJSb32
         ZR3c5KvXGvaQFOftX3lQojlnW17WvvSX0V+j3cMvysuTXfXmHcc2leF8zEiJ8LXEkDCY
         r74rDOeJ0AVuIuCPcyNYoZEdJzc9CDiDAHG+4FW+tdXOSWOarCPUvhWaZJxH4g8D5Mv/
         oza+SpRPgFkAnuKrJ/JTP49J3gOINkulvTbJa7UBBuTs1jkipzZKzuCX8hnO3HK8czxn
         biQcStlmFpnwXGXLgdeG3cisF4nLG/LuU4ZHVzQqlehp2WODSESAy7ige+0MdTFaofZn
         koUA==
X-Gm-Message-State: AOJu0YzWsxTxF4RamQSrDG3azgo3inexM79tysOf4BpyeBDzoZF/OpWs
	90SWkLPYYJFqRY7O1u1nGQHxc6fIX/7sbbKuQGvgxMe6Pi6diIGZPCzoZC63Zfr+l67OtQEq513
	87+bnMvNsDVGkIYiXtSTaO1GrjmaNWkQ=
X-Gm-Gg: AZuq6aJ3kXsN4ag6017U6eP+GFiCcXgTOElMKWhK7c8ek6f7DzkSKaMAsTZaUhKnOWC
	kUhr19kLqnV5flaqbHUx+ukCjRfLCeBHqxyRdGLwJ20kPO3yeaeG4cvcZ+PvxV4VfAjjDPTdP7X
	kUGQWNuYggEPbPbDuPa9ktac9saY0ylpjM4gYXOTrIXYQap3BvNXEcDTMBQTOS0GknZQuVGQ9XI
	RzNYFjvmltzbnQMBpz65Xi7T4Tcylp7fXXdZsTbcC2XwU75dtrvWUp9Y5MCI8ni4eGofMpku4KO
	08gKOTbgtjxTYiX8ojrpr7GUugnhQstit5dXkcMHcdOxzQoFAds/Lea79MxZjfrXWcJzDG6lSVi
	oymz8QLynHz+asgkdDxnhYWyckQ==
X-Received: by 2002:a05:600c:1909:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-48373a78e7amr99696475e9.35.1771095437570; Sat, 14 Feb 2026
 10:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214115431.55574-1-anandkrshawheritage@gmail.com>
In-Reply-To: <20260214115431.55574-1-anandkrshawheritage@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 14 Feb 2026 10:57:06 -0800
X-Gm-Features: AaiRm539bjiX9dqVXUAYw3s0ZVhaVMbaDETFDrJyUdUXB3KeDpMAwmZnBMsEyFI
Message-ID: <CAADnVQKFHW09Y_mGYVa8wLD-1+W915WmZA_toO8+BUzJDR73rw@mail.gmail.com>
Subject: Re: [PATCH] bpf: expose original requested max_entries in bpf_map_info
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 3:54=E2=80=AFAM Anand Kumar Shaw
<anandkrshawheritage@gmail.com> wrote:
>
> When creating LRU hash maps with BPF_F_NO_COMMON_LRU, the kernel
> silently rounds max_entries up to a multiple of num_possible_cpus()
> in htab_map_alloc() to ensure each per-CPU LRU list has at least one
> element. However, the original value requested by the caller is lost --
> map->max_entries is overwritten with the rounded value.
>
> This creates a problem for userspace map managers (e.g., Cilium) that
> reconcile map parameters against their configured values. When the
> kernel-reported max_entries differs from the originally requested value,
> the reconciliation logic detects a "mismatch" and may enter an infinite
> delete-recreate loop, as seen in production incidents where non-power-
> of-2 CPU counts caused small but persistent rounding differences.

Clearly a user space issue.
The kernel side never promised to keep max_entries constant.

pw-bot: cr
