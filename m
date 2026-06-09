Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF04B8DD0
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024675; cv=pass; b=oW42zLjm56VYVIMi1Jp3QNMxJZ+QwBD92+McSIJVhbOof5cHigDZrrEF34wAAzS014jcJk+8jh+XEXHUPl7yvaWhF93mhay48jug8Yo9kMkvGyVtb4+LlUZ0vtgdsdw3AMNEVI4bo+vq5X3JRf3zdBw0PX9pnYozA9zyF1uISnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024675; c=relaxed/simple;
	bh=BAbbimQpEHy8btdA47PpCZm87JFf7PlY50yw3RdP/XU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F+j9LifF+eYe1uXEX4LOfBHIpEns+g35YUSckjTjkKUqh+aHVdS7VwsAiB2hWRKqGqzHKhQizgtZSZ8ZdK0+dUmHdDY1mfBm0fKvxvnKj/wkGUBRM/1ODbcbG/4GHLKQwFLVRLdtycQsMit20Eup7trW7PZsvr16UEu3hY6mUnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmIhtM/D; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmIhtM/D"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-486304fa184so5103237b6e.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 10:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781024672; cv=none;
        d=google.com; s=arc-20240605;
        b=jr21Yojcww5kXSAZ++cNbc+UFm2FDh+nT775+Z6Yda8tlnN8uQ1/Hy8Q6ZXWEHpkiT
         5mtAzKyEgr4i6e4anR24Riiy1Sd/TLGOI2Hp7kmZffQPLZiuaMEIVirHYM7yFcvz2SU9
         86anl8orolcdSRRFLEcWvCLItJMOkIw3LSHK8o61PawwQi9dfxCo7S7RpMarlbR7Nr2y
         AWFBhoovSFPSly0adTFYKvV49jb9Bgm621X3a7u3V8auZvIexD9No9YJwhvTqIyt7pLd
         49ApL2ltVXxOtfhMB5ti1mRIcAJaqmn3Jm0uK2KaBRtuKfKilg9J7cTvwJxfJU5dfbQQ
         //4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=BAbbimQpEHy8btdA47PpCZm87JFf7PlY50yw3RdP/XU=;
        fh=gjQP6wX+A2VuFnDRIrL7V+RhH3sXHicguRWQSuXrS/M=;
        b=HFz0kGd93koAMJ5RZw1GLsa/DbgbLDG5bU2yTa1oiF3LBIahSk2hc70L170HClGoUb
         H479XxY4tATuoixTqdY9Qzv0/LyVx4giU7EXuzKtuZ4fNSgwo/SDvubbJZcDkwLx/+I7
         RXKkf509YQswCjepR3O4D0GcLKCu28tjmi9OzqenQ+ypHi+mof1En1f7SmOegq6erzum
         1LftCM0S3sjjyviN2Ys1bp7CBR07yrJKN1Si3sQBrL/wDt4YyHBQD7d/l+vF2HhK260P
         wB/pE1TZPdNBgBsHV3CEJPcO45pLTRSsUg8jFXJM+ETaS5VqJ3B2fk/6CO3WCgsKnFZ9
         JckA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781024672; x=1781629472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAbbimQpEHy8btdA47PpCZm87JFf7PlY50yw3RdP/XU=;
        b=rmIhtM/DZGpq20mrEqmdXK+VzTjqetDeP/UI2KQNFLhJyFnL3MxHIBFzuKsmg7bRv3
         7izzd8jLJV8UCJ4Ot95kHUMMmspuLJFTlKfc5mA+U5GCBCluK/aJz2RuZN9IRUk2Geqa
         5qFRH2PAYtxdSeNNfCQLfbJoU7apJ7iOnBsITXoYgCmhX2CCsCagsDr80IQ0GZX7ouzd
         iAzIlI+ufMwTWEnOfvMKIlTOESiUfl6/e8t4r9FmBTkSWudxEkmT2B1DCuL3D6FowxHD
         bhvz4de00J84QqvIceYjbgYCiOX6uxhTTNp6UM8OcQJtONp5a38IudKcaKe9O3z2pss2
         QfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024672; x=1781629472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAbbimQpEHy8btdA47PpCZm87JFf7PlY50yw3RdP/XU=;
        b=H6ft6z84Tzshz/LgYWcGS6e9oAM2PZDroyO2kgRtyt1sRWwU8uHIBPnLxEjRCzIfP+
         wN7hJDquDgNiJspfF/ARombFQ3MzlH/YOLcX6zh0JyBX19oUXCr/0pZ9LkDgWwXE1keN
         2UxsC67T3c/XwFTtuSUx4TVEYUyV/Z4rqIidm4lywOdjDcIdfTbvadlAAIxLGt2JQlqJ
         R44lI8mAu1chKEQEZ6i2x4u13pytfY8sfFZTrFZvrqKMGHFQ24vES43iJDoAmHrEcgMs
         RrUI6gHp0cRlt3SPvRX6IO0tPMScD6rgQl3N96/HpbE8QsoPJcfYWVFFmQIQW3MbCZea
         xiDA==
X-Gm-Message-State: AOJu0YyAQMJurytPM75v2ROtBCbdLqBh8+7SATkhnzJpexa927uuxVLH
	nCJuSeIYPJzqn5nkBxWU/7/IEahk0R4sIJlu6JjqbUAxb37/OoocCG8dosD0P80gKIx3NhQPQDJ
	ywV0DVNwAaWqPX36e4Z6PLEo/s1PABrxdMfSLM+g=
X-Gm-Gg: Acq92OEsXaof3W8/tfGAE1nB8Bl5X5V1hb9RQHguyR76J0pIZ/1zgipgtlcYDL8aj5p
	A8BI9I5j/2LIwpvvb4/Md7h5vI3OTVQ6sCBAT1ENeSO60mPA/J01U49qNIM7d3Th1SpTUtz1yvi
	tN/byMNGV3TciSaz/VoumUMRcf8Y4in4NXilCG9Q9hTsmUf801A74mbqbFqFPTf0JiEUwKVlXrw
	FhYFzjJpBkNDJzXiUb3ffoFei+fuKdCDZFe3VHpuqsoodJ0oS71LNGWgUsy48cBfwu3PV6wMeSN
	/6g2naAgeOmDNIKEzuaOBugfSw==
X-Received: by 2002:a05:6808:11c1:b0:479:fa21:adfe with SMTP id
 5614622812f47-486f0007210mr2291412b6e.6.1781024672246; Tue, 09 Jun 2026
 10:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mahnur A <s.mahnur.a@gmail.com>
Date: Tue, 9 Jun 2026 19:04:20 +0200
X-Gm-Features: AVVi8Cd7s_fOHtIxiieh-sY893tbG3cF_CrxC7Y_7zFD9IRWyK2ShY6Fziz4pm4
Message-ID: <CAJ-umGQ9edRUCnaLYTW1F2wbRDhxM7RRra545ZYbM+8++ModaA@mail.gmail.com>
Subject: [BUG] bpf: Tracing progs on the stack save subtree can result in OOM
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I hit the following case on the current mainline kernel (7.1-rc7)

BPF tracing programs that allocate something and have a deferred-free for i=
t:
Attached to any function in the stack save / unwind result in OOM.


KASAN, slub_debug etc. all save a stack on every alloc/free.
An example bpf program updates a map element,
before lookup and retrieval of the timer object.
It then calls bpf_timer_init().
If this happens at every alloc/free event,
a new timer object gets allocated with every map element update,
while the previous one is deferred-free (via kfree_rcu).

All these alloc/free cause cascading probes to fire which in turn trigger m=
ore.
The timer objects accumulate without bound.
kfree_rcu()'d timer objects are reclaimed at a slower rate (or RCU stalls).
This results in OOM which eventually kills init.

Please find the reproducer, config files and the full backtrace here:
https://gist.github.com/MahnurA/622d0cd44df686e241a4b043023871a2

A possible patch could be to not allow BPF programs to attach to such
points at all,
but I'm not sure how that would scale.
I=E2=80=99m happy to test debug patches or provide additional information.

Best regards,
Mahnur
