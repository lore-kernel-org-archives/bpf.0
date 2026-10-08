Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A1488D95
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453307; cv=none; b=Z0ggNTTBzZjuuEamVf5/zw3j3TDWS+2umUShaKtMTdt4pEIDspgKduz52vP8bbhRsBHe8Bz2cA4Bd87w1Z/0hMWHUQqECB8ooidmStyQ4dvtuUXVjA3e5ag/d8OHMQsNXKCyvXQ1x0DWMEuODYBdHXJvf4U+j31nMBGo1AttUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453307; c=relaxed/simple;
	bh=6mKzhGDxxBQhe1L1c9AjcjAufrdgnU2foAeWHDXdGPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSqSBBS9/a4sM+7JL2krs5PHuO9JQ+6BR5iUQXGc1NhSRHtJ7bKCbSk5qxU5JVYXqjtsnPXswwFIdIQWcX/rCgdC9Xcp7uri5znKAnCS/IXmBKI9/guw8QeYoTLTMHxJqN1wx+YGRqZFdpb48faCVAk/yW8SkMdSOLYnXOKIw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFrbjmrG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxroKc7h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFrbjmrG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxroKc7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791453304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2rwd4c1hFdRk+8gic1oWg1e821LH97Si/hZy7R8ff64=;
	b=SFrbjmrGbOfxNABEf6Uk5vyt3c9AYHTLhzFeJY3s9/c8lyvssZG8EmgVSuvT0TkcF784CN
	iXGjjr+b8rdzXH368sZPF3DOFXDKWD8zIhqip7NBR+PQJb0E28jOgfK8Xupfid+2EoMftZ
	9Nisqi/KPt9Ke7gLzMMjOLVG//UMy7Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-FcF79VJHPNaclwrnSLWeBQ-1; Thu, 08 Oct 2026 05:55:03 -0400
X-MC-Unique: FcF79VJHPNaclwrnSLWeBQ-1
X-Mimecast-MFC-AGG-ID: FcF79VJHPNaclwrnSLWeBQ_1791453302
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2e49c5ff09so562991166b.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791453302; x=1792058102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2rwd4c1hFdRk+8gic1oWg1e821LH97Si/hZy7R8ff64=;
        b=NxroKc7hvVzpBGkQmQFsufie5p5QKFsZI4tUtA8K7KdpsJkfXLnlh2FLfzqiIZA6J1
         +m0m+gwlK2ltmbNjw8emjWxtxJiJ9+622Qjoz8FcArXcB6iR+OG3Ipe6qi9Fj0IeAhlM
         j4psg8q0iwB/x2k2S/2dEiG8A7WU6JwQZpt0zDiBnMyhxEI5yMxSOw4XpquUSkpA3ZwZ
         bC+kWh826PNo1tHos5xw3akK4D3E8WAdPPz8yThnvYElB6ej54aSHQAhVDdxTkCXvONk
         yq8eKHEDhHlUsesuc3lHMeJECn0cFqCFSaXU/qjLSlkhN1siPkbU3/kjOpqvfeXsd/My
         Sm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453302; x=1792058102;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2rwd4c1hFdRk+8gic1oWg1e821LH97Si/hZy7R8ff64=;
        b=LbJCcl5xg/4aEaVhLkRy33r0iBJ+T5VSib7cyqyDv9OceIjzb7FCIrWyeG0xS5Zwy8
         hqHg3Z62BbDHnHpTOMMbM0yvn0lFTaTQ0MqaSXBhI/CoqPA7pTHXfkxLKws/4iow3WEQ
         Znc/CWS8H0MSZAYmFV/noOORnZli24k7XF8rA0kI3UyofElXxnOMrIbeGloip/qbXS9V
         R0zxHR2RWk0xvc4qhFQUa1zEsH+ruHaw+y57JfiolzBxkPm1Dm9RSQkg08s7WKzMvWln
         Lv54IPkeaUIaU30uoD/91heFNPO74bax4z5UtW88e78n4PwxLzHPb9n3OH8LNi3epBbG
         WvVw==
X-Forwarded-Encrypted: i=1; AKwUvByJsJGexxhzR32R5d6wxlC33ECy5+Ow6zgBkTs8KAHlV7C/e+anfW0woc+PkcOWthfe/d4=@vger.kernel.org
X-Gm-Message-State: AFuF++nz3keDMKytAyrU7ZehtHOU1cQPsA9fO9OVAu21u39gbdM3wyEH
	YraMxjW3gFT5g9SEGEauMw1FyQu6fw5V4XlWqa1W2TeZWoMDHjUfByjazx2oiApRMNSZ+a5GpEC
	JDFYLbD6RxrtP0NZM0YQRmih3UiUQYPQEw2ohVoSF/3dKDcdnNoTmAA==
X-Gm-Gg: AYBFou2LK5w3bE9vfYQbiZ58tlD9jJlZgN1a+zeBUHOtkuRu7VrWnwnQpOEVA6tG/vw
	9pdp8qvL/7bW1zrY8rE4udoCNCxAKQByZ69haLireoq5aJILiB4lCDdxg8i7rJhR5KQ6qj1T+Px
	5lDy97dyZHv3oTcKM5OSXd3xq54Fvd2GFXzx8p0MVrvCe4DVndiH8R65M3wgo9zIn31rlDYzI25
	HwylKrGZPSWjosllTMVD3cd14WW74pbrUX+NfulUVVvKdyuQWm8RO7ykrZr8SP2ZQkECwWfJmis
	HQdTBkmf8iZh/tcVyQqXyrrVsJpXt/hOEwLOE49LQuL5ZCHJr/wpnHAnH2ltFRnZDw/ZxwbpmrT
	EFkWqYDTPsqhKcUQ76XSDBZRnoMqlm1KGcDP3yPMe280iTpPu9QYr3ulljKs3ZrhjR5g7BA==
X-Received: by 2002:a17:907:8688:b0:c2e:3f49:df04 with SMTP id a640c23a62f3a-c317bbdc08fmr523188366b.1.1791453302312;
        Thu, 08 Oct 2026 02:55:02 -0700 (PDT)
X-Received: by 2002:a17:907:8688:b0:c2e:3f49:df04 with SMTP id a640c23a62f3a-c317bbdc08fmr523186766b.1.1791453301931;
        Thu, 08 Oct 2026 02:55:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b00aa2b8aasm1188417a12.22.2026.10.08.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:55:01 -0700 (PDT)
Message-ID: <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>,
 John Ogness	 <john.ogness@linutronix.de>
Date: Thu, 08 Oct 2026 11:54:59 +0200
In-Reply-To: <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-06 at 13:29 +0000, Alexei Starovoitov wrote:
> On Thu, Oct 01, 2026 at 05:20 PM Gabriele Monaco <gmonaco@redhat.com> wro=
te:
>=20
> Overall looks much better.
> Some of the code reimplements bpftool, but it's user space.
> It can be cleaned up later.

Thanks for going through these.
Indeed I tried to reduce the code reimplementing these things but probably =
I can
do better.

> > +$(BPF_DIR)/%.o: $(BPF_DIR)/%.c $(VMLINUX_H)
> > +	$(QUIET_CLANG)$(CLANG) $(BPF_CFLAGS) -c $< -o $@
> > +	$(Q)$(LLVM_STRIP) -g $@
> > +	$(Q)$(LLVM_OBJCOPY) --remove-section=3D.rel.rodata $@
>=20
> What is this for?
> Released libbpf ignores it with "skipping relo section" message.
> Removing the section only hides that some pointer in .rodata is left
> without relocation. What is it? libbpf in bpf-next needs .rel.rodata to
> resolve pointers to functions. See commit b223044a68d5 ("libbpf: Resolve
> pointers to functions in read-only data").

Yeah indeed I used this to silence the warning. Apparently right now the wa=
rning
is gone (no relocation section even if I don't trim it), but I went back to=
 the
initial version and it was about a bunch of .rodata.str1.1

I'm going to test a bit more but I can probably remove this.

> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_HASH);
> > +	__uint(max_entries, 10240);
> > +	__type(key, da_id_type);
> > +	__type(value, struct da_monitor_storage_bpf);
> > +} rv_mon_map SEC(".maps");
>=20
> Why hash by pid?
> Use BPF_MAP_TYPE_TASK_STORAGE for per-task monitors.
> Once there are 10240 tasks bpf_map_update_elem() in da_create_storage()
> fails, the error is ignored, and the rest of the tasks are silently
> not monitored.
> Task storage is freed with the task. No need for handle_obj_cleanup,
> id, target and PF_EXITING.

Great, I wasn't aware of it and looks much neater. Will use that.

I couldn't catch you yesterday at the conference, but I can summarise here =
what
I really wanted to ask you:

Reactors in this patch use bpf_printk(), which is in fact a trace_printk()
instead of a real printk, is there a technical limitation forbidding us to
create a kfunc using some flavour of printk_deferred()? Or am I missing an
existing one? (this need was brought up by John, Cc'd here)

Not needed in this patch but potentially required for more complex monitors=
. In
kernel, when timers are required, we allow monitors to use hrtimers (precis=
e but
heavy), or the timer_wheel (lightweight but less precise).
I'm not aware of any wrapper of the wheel in BPF, but I think a few kfuncs =
for
these could be useful, in general, also for other programs needing a lot of
timer instances or simply light timeouts.
What do you think?

Thanks,
Gabriele

