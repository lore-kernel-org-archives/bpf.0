Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771997;
	b=H1Yg2KBc4uyI+Unga5GxRXhobUP58ShDOBiEansjgjknd/3DB5wQy00ULEJGGsk/y4Ss
	 DTdd9D0/nsTDJRg3r64k8+Q+gTP7hzQcxdiD+fJr+hOekmRPVN93HtPm9dzubNQwQyx0G
	 tVG0l/WCGeWXoFCFArmrs0ysLn3v4i7mKwWCtLn12vp5q11VoxuSkskToOWRTKm8ZT/hU
	 TWVBebziyROAgParVCOCxxO1qa6ImHemqfUPKVYfuBmT/8S2BW+neoHScxLJ6TgYl+cDY
	 5tM19amFZ/c3VX8YqYoE6NaWxB5k/62PIG2Uw998MvOpGJIjgSWwW7j/XbEhwq7q/hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771997;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=3ksVuDUqMf/kfLTk7MjjHXeosYCMKCsBfhfswI5h2f0=;
	b=uQVvM4dNcX5oxY9pz8dp21VqDaa5FicgIufklwkwqkt2pv1xCiw8zindMyqDO5/qfI8B
	 uBQ2DmKIBNuV+DKGXlXL59YHdxUhNAfLueq8yOSMujsvNKTrCTsD7W6P4Jt1tOeG353LH
	 4DcLGXNH7tUmwy0Yc5wcXZVYNt8fCEx6GSf+NrC02Hcwgyakbt9GAXxAuT7O6s+95J+Yl
	 bdCeFVf8CuTOAo1K5ibXmawb2nXuYF4Nv4XkpGBtV0NRsbGGak0MIAhh34p2EhYp6BXSa
	 V+GdqTVOb7d4jR+6SAGhUJUgsCm7o+DEYphZa1mRdp68shJS1Jxfr+mmlJwD010bRxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI5nCU3z;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OMOQ6XFE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DBD606A31D
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 16:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72DBD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI5nCU3z;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OMOQ6XFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792771995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ksVuDUqMf/kfLTk7MjjHXeosYCMKCsBfhfswI5h2f0=;
	b=TI5nCU3zwGltLYkkVXScGKsEr5WkfI3WhnT9wcU1T1qE8h0WAAH+wHSMWB/2HxbIjYdXI5
	j5r8CEhVUkyTSYzoT3sET5/TQfPuCRyUE+1TvhAfgMlew9CWtKdxf5vZ188LD0D2z0lTH+
	kBa/dmMnsBWyh0Oh0sSodIAu/Q9sLn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-tq48ifwHN2q3qBq5xURjyA-1; Fri, 23 Oct 2026 12:13:13 -0400
X-MC-Unique: tq48ifwHN2q3qBq5xURjyA-1
X-Mimecast-MFC-AGG-ID: tq48ifwHN2q3qBq5xURjyA_1792771992
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so7395245e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792771992; x=1793376792; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ksVuDUqMf/kfLTk7MjjHXeosYCMKCsBfhfswI5h2f0=;
        b=OMOQ6XFEOrC1l7DRzz+7yV+g63E9Q4dUJD5q3n1N8zneWcHYMcATRFHMPGKdjvT6hb
         iIrrBNjU4sKLpS1WGFH8R5+X66L2EVmPv7+pH4axrFNAT9G4g6hBt02H9yGX28WVoKka
         uMDPpNf3UXTwWYlT52YvPaa9R0/TaODrNvyJtU8anbRyNqLQXCMGrkQhuD9gxMJaweDS
         fxEzsXk/+K8jDGkPf10g0LaQ2EF+7/O4kekRuJVSs/8OJ9dCcX4dPGlK38OSR1uWO+xD
         3K/t32TysGIXnDaaKmyBdeck6K/EIusxs8Ss7PTsrvXSlzkxFS5MKQKYQdML8OOivDT5
         EUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771992; x=1793376792;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3ksVuDUqMf/kfLTk7MjjHXeosYCMKCsBfhfswI5h2f0=;
        b=kE4MRrxUpsGARabDnDZ8guTzvmIDvZH09t7KY3ufHpY3rFL23CwhImG1lMCdoPwTeP
         HIPVzzm0y/uCndfY1X3+PB9y/pYZf3yvwHkAeMjdmYf9jfotGTH+do0GHdGi1xRAeJ4i
         9IcmxlbFHTnHDRV2K0AoxuWzD5C971vk/tM51P5MidCx9Eap121ei2k58V7dL6vDtGnZ
         RzMCbwA/VBEtcKw3Xi5koUqWFkqjRcFZPkMoxUETbnBI0RKrdUtJ2ubG3X6rcOv1uXM0
         VaTemPiUPposPDQAkMMjD2+2vdWbEKPs0is+559XsT1ErOCWnznYtnnRg/8wJPA/mi6I
         1yHw==
X-Forwarded-Encrypted: i=1; AKwUvBwQax3Pi7mdn9W3Nj4pW5YSZkhePHyK2G5vjsVDpZnRMB9lpxeX+Pmyybt1T7UdicKmtmE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiYonNXL/BpNa9blu8fUBb2DdaCQiqYeQJMfGTEjjYJIM+X0bE
	8XCpvXPW6ONgyeJRlvi0Rv5fWBTxLXPR3IIofYW2uHyOkfHKOmohIocSItX/AExCOZil++rXkPJ
	HOL1wqS7KQ0QkXxC6U3PkQOFpi0PaDHp/lN+YF4jLJ65EwSfyEC9ToQ==
X-Gm-Gg: AYBFou0JTjVRj8T7GjTSvjTzxEwKVxzxb6qIw8BTJtcyeToFDpIep6hyFIpTzAtiLcx
	ixhsvTBfE1HGj5HPWdcLwgZGZtfqqQ+Ij2z5b7yIctGEXabqLw5zalR7iBimuvBMKzkmO+7iwuc
	EXR14acCJ+1cmqY1oWYwz77daysJTGnJDS2OF2Inu9IQQp+AV3JJlgRCYsigDw+dGSK4Ywv9PtG
	OYub1uinULnYAdPuOt+mg8I5HDesgvk1+4XbTG/vGT0Syf2XAzjgcQ4tDowZ7ul5brvBXL53phI
	nlQt4KO/ML92mNScd+CfLK7TyLBeH8ai2m+PNZU+rPdpdmLiyRRukzj19VOmHXyNvyv2Bfb8j06
	D/4/+WPIP8CQDojMHx5osJN4LR82v
X-Received: by 2002:a05:600c:441a:b0:4a1:dfd4:9430 with SMTP id 5b1f17b1804b1-4a211eebdf6mr31752745e9.28.1792771992031;
        Fri, 23 Oct 2026 09:13:12 -0700 (PDT)
X-Received: by 2002:a05:600c:441a:b0:4a1:dfd4:9430 with SMTP id 5b1f17b1804b1-4a211eebdf6mr31752395e9.28.1792771991554;
        Fri, 23 Oct 2026 09:13:11 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3f0b8asm757666f8f.11.2026.10.23.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:13:11 -0700 (PDT)
Message-ID: <3a740fe36bddc50d43be80a0163e5faa0bd96d2c.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Fri, 23 Oct 2026 18:13:09 +0200
In-Reply-To: <87fqxwv4w3.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	 <87v770uuyr.fsf@jogness.linutronix.de>
	 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	 <87ik2zryzo.fsf@jogness.linutronix.de>
	 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
	 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
	 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
	 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
	 <87pkx5q1w4.fsf@jogness.linutronix.de>
	 <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
	 <87h5ifqy6w.fsf@yellow.woof>
	 <a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
	 <20261021094853.29b9f7be@gandalf.local.home>
	 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
	 <87h5ifvw3p.fsf@jogness.linutronix.de>
	 <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
	 <871p9ita52.fsf@yellow.woof>
	 <19beabe52e6d6c6c98e3ce6ae89867356e18b2fb.camel@redhat.com>
	 <87fqxwv4w3.fsf@yellow.woof>
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
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-23 at 17:00 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > That could work, though we'd lose some ergonomics around filtering even=
ts,
> > not
> > so much in the unified tracepoint thing but in what fields events have.=
 We
> > would
> > need to parse a string (so I wonder if globs can express constraints li=
ke
> > matching whole words or we'd need to arrange the format to accommodate =
glob
> > limitations).
>=20
> Yes. But the transition event thingy (not sure what we are naming that)
> is only for debugging RV, and the error event should not appear
> often. So I think some parsing overhead is not much of an issue.

It isn't quite the performance overhead, it's that instead of doing

  --filter 'current =3D=3D "foo" && event =3D=3D "bar"'

I'm going to need to do something like

  --filter 'current ~ "* foo x*" && event ~ "*x bar ->*"'

So you need to remember the format.
You wouldn't need to do that if you know you don't have overlapping names
though.

It isn't a big issue most of the time, but less ergonomic for us.
As John said, debugging models is still a use case. LTL puts some gibberish=
 in
these events but they are useful for DA.

But probably the simplified code all around is worth this mild complication=
.
Anyway I'd rather try this first for BPF and then introduce it for in-kerne=
l
ones.
Deprecating per-monitor tracepoints is yet another large change I'd rather =
keep
in a separate series.

Thanks,
Gabriele

