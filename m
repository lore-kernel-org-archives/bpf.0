Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123600;
	b=cgGpQ199x/WiexRoC6Vaxe2wgp6WS/gi7Y13KAGoUhYwNuKlxtxK7m9TLvYEwLeDhgMP
	 lyOQRg/JEGY6aXeMqsze5raailioLBO+1GHykLox+j9qulf/XvfA0thvEbE/HRTXx5Vg4
	 44KkriSlhM2aa2xclZHcQxrXKEls1N6Hxf3Br6nyVMPhR2083FXsG4wN+gC/2RF7naKwc
	 nHlvoDFzmgPY5116V1AoTQZEhfi5DMUo4kuk7kg3hHSpMa/FJQVKXiM4cJfwNWy6ALZNB
	 Js7kni7hKPYMUc05NFbqGcpfR3be+/mAQEmD+9jhIk3DUbIkvGpFF4qotp0WWmjDO7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
	b=TmvtPpJAlqEVMSQorKZug7hXqxLdvXr5rITkKDZnYf8EAFZTllQP8Qb6otcNy09jf9No
	 jEBw0SxwGmO3chLzDZXasXehRJ4YQP0DdkfJ7MrC9ukbHGGhvarqk5T/YpU71bc7Wl+rL
	 gyV6JaepXNK8vP+t7gxkC2YzbnLm/bUjA6fjM0IUj25tYSSpZung9Fi+L36aix6hjqQMg
	 FmvGBqe5Kgrwf+lcvFDtJ/zfwFJ6sJotX9GFvsQ8tNT+klwqv/Yw2ohxtmtc1s1F9Tb4v
	 VnrLJhzLyKuNZW8/paJd3X+LsC6HVg9wuiOR5jjzWCnhQbbmBfpOP+pX2j0Tah5UJ4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A7606A323
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF6A7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4677aad67bso12560666b.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123598; cv=none;
        d=google.com; s=arc-20260327;
        b=XHayWxfML4CHVCRJVaAAbAV8xr2x40eSNDuaa/yvVQCo7WPWVpeCAUJdOcAy8KUwl0
         u+JAyt9nCHzCqJUhCzuwVvmKiMgpOJcQ6YYzRE/zcfL8KD/gkPeOryu1eDnbO48i/QP0
         2SzV034D3XsvnowRbxFY1mcdQwTsbf7SJKU88JzOpysoUd8XRBh70Upifr2pTRIw8bR3
         nZ2TfQ2X5lYntw+h02K4bC7sOKtpYyNX4r5Gy3fQgBhalf3+sYzubA2qbcYrJRxr8lqR
         BenEt6ZisCz3BVnjzuvcl66oxPaK6Rmedgc8/TWq9213dBsEKkeaT+d9fuPRmseBZwvA
         gnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        fh=rAy3WTeFQR3id3SqFVGiGV02RQx65nKjjJbv//Opiik=;
        b=FV/YQNBLKUmFHN0tSfUhXMwYulIowygYjoCWyfV+xm7IYYMsffhD7knH+PNlB6fvLh
         taxdTp5M/whkg7xFa/jmz3Qbt0accfvujDoabB7qxbt+eG/Vrk7fpo9qmtmxn483BBdE
         fVxw9JBSnZRTDMR3n/+lukGrzH+NRskFY9Vi2X5Wnb1cXPVkTRvBlUVfK+gmKgtdwbKs
         P8gIfpFlTMtX8akd3zTVRdkaEzh16/FNdILfwonspHUsuK/pl0NvTofodEFk40GgufqZ
         iCEG0MgO5C6mssHnOQk/oV92nFKfVObcIjOiTLrVvoIeG82deSiF42JRnSY0q8PnZt8s
         1F4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123598; x=1793728398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=inJR6ox6aQPgzkJ0wZYiPBugaLW1/kUDoRUxznaXNPrxE2Wn3DkQl3afONPaEwO9sl
         vnrt6FP9OFfRf9KWlwZNng3ZlaCrfp3bQxPXGc+Gx+AORrKLJ8WZpN9m6kJEM6IAqHPq
         Jk4iMXPxJgkZqxRsoYIxQcD6CPbdcJbwTT1mEJs9Oh6VfooqjmJi5DvsYqRTbZ70S79m
         W2gdT7rvplj4k08tnzQQgxgOTLo5uqZ4a0mScYBLYVaYMXTVeZPwvd3azNIWeu6/sXO8
         zyeS5P1gD5N0vXZJTHB1IRGypOyTZEZWjLyDPXDDqsHxY4MhwV784zCuBQDBJ99Srvxy
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123598; x=1793728398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=KgFVDRb8Dhhz7oPG/vJX2YYJh4RndkSC4/Ccp/v16tzmmzrt/h/LT3APxlzoU/j0JQ
         WAbW1it6HbwmcrHmKW5l/1IRqyV20+CVsqpsKuu5pmu/fmMdhigaO1CNtHgPOisX6R7u
         B4VeoefojcRepG3mPTg3skPjn1zmC0LFbbOWZsjex0Lrgc4hRdNDnhQdF0a3dQs15YLn
         bIZ/u1m42BZUl0I0hn3QYv5hgVcVpOlg100ANYOrmtkEalu0JyYvlMHCNjHRedOI19VC
         eDJYAUcJwad4HAXuqkw7eHuASCD9Wflg+ssn5gTuL7UOZVFFqskWoOANNTi8ppfo5Dur
         9Ciw==
X-Forwarded-Encrypted: i=1; AKwUvBwe2oNqCGl7uY2L8FJzoO8dhGBXyAP1pTA9tZp8mzmdAH2Xyz3Kg5WM4MD7Vw2aroofOao=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUR6LzTyW+XAQlrZhauwvVFeA5n6PvTYznfC/JvcvU3AGE+mKF
	rPO+TmRHWOhEVTJA5MpOZjlr0ZcgPMOC+jXLFJEfOnm0BYL+DZf7dpQwxqND3tA2GL5v6y35ovo
	kMbiT2LboUzZ9/ABc3CM9k5cLZIG4thvBjCazVwN7
X-Gm-Gg: AYBFou21F7CB4pHV0AptloeiBvC6eVK7RvEYueko8BG6pjpIYnCMNH4+Dq/maXZhre7
	z/EJoHbCgwVoyhZ0xuY1AclaUGEc5S6i3IWzI+/BBtDwe0XdQFHiMbzL3pEi4m/pEflejaJXos8
	X0PDKGN8f8ju6cUBQ3tr7zboWi5pMC5CEhY9mipR1QChxckFkuOW9wE8qKhln9pgH7I7H+TNm4S
	AfXf2mAvzEUMucf5k2lJMGroP8mfO3XBx3ru5fpAX2VGMPZ8mH+Q54Bsd0AbffgjthBkrLgjMGN
	b+GbUgPAt0sSgvNhIkQU5QcIg1TgqMN3FfA8dqXTCCtSBVx7F3iRT+0F2Xic8YpewY8jrgquzsV
	dsc9PG6CJekzWLvwDoqyr8oLBOep8wmdYAXPl32iCRmdi0Gfv3dg2FNt7i9o/IOkk6tbsXEKj4I
	kUZidiXW9obzPkKqzpaYyr0/NUj0C1Ll8aVxQsPA4VOFb9LbICavD31ns5lr+ZMx1rE9kZRXCWL
	3oHUkVlEpXA3g==
X-Received: by 2002:a17:906:dc8e:b0:c31:e958:408c with SMTP id
 a640c23a62f3a-c46bde8b464mr1159692166b.38.1793123597614; Tue, 27 Oct 2026
 10:53:17 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-2-jthoughton@google.com> <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
In-Reply-To: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:52:40 -0700
X-Gm-Features: AclHuK_7gnb7g4GjAy_SA5zcAxXhabVZixR-oCAtO-qS-tkfEqOEG_LlV9pvyY0
Message-ID: <CADrL8HVgOYb1hzWDJzm4sCrEAR7PL1xBv-1zTGebTusPoDsGXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 7:41=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks, Jens!
