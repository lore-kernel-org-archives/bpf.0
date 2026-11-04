Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793766353;
	b=bzJMuRWTGX6HJxP5MvZVk4JGI829Qn1XKrD+YvCwtlK4Te1+P6heRm+vTisr+IXXAHGN
	 n7niOfHaRREHIx17qfXhkviaW838qmuqZWUdM4zTCdSLB+te6gHDpRnNEtZ4Ncrt3CE7F
	 Coozzh1K8Zb4Uu/pJh/G6HpVKzml8MszDYYlAha/muZaB0tFg8/133p6Jej8w2vG4F6Vs
	 proNEcCaZzL27mZdDzqF29w2avPZaa9AoJLuCRP7PYooUQl3uFwz+wuXf+ermZLwYX8Jt
	 qELmH6o03NY0Rjya77QkjoajlWM2Lppol7ffIk49A9kIwTfkwS7EOg1VaE5dM05qaGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
	b=PBAmVdvkZjzgU47o8yqsqTYHoKV2TAjtRORBm9IDXIrokP0n2iVyeryhaTFxAE0ta/+/
	 LKRpDdckjPN0Fcaf2Zjn7wVMIbALDN0wnSLON4shtf3pYoqyfgDdpFJA5vLEujVNm06L+
	 lZ92ZK2LnT43cIxrn6/tp+8v89c2YRESqkzQzcDZOeB+W8RO8XAlO0PkTNNE9wzAMn9CW
	 1l2SgJy+mndZTl0G8iseqqfuEBPR8OxEtEWGJe8EqfPl4ymVJFYXN9ujY4FpxykKUxHTI
	 8Mw5bsatxKYPuoRCiE0MRcFW+h5RvRzU22MMeDZ/g2IkOxIgupAa92DL91SIE7UybPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NyYT572y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA417606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA417606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NyYT572y
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54492d8a988so158001cf.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:25:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793766352; cv=none;
        d=google.com; s=arc-20260327;
        b=B9NGqfmQaHaDbf0TOjkYeYe4M9tmhM35tiZCzT2/gyV/EimF6KY7pDLFMqZfkeEekj
         wydoio+qqVUna9Gxiikykax6h/U1iFvjd2R+XqqiskK2vpVeHINE5prxprkqVg7RNJGM
         tfotv+lUfzF2DnxlOcYpePkOfLOuQXKrivZWC/cHJcCrTHdMLtWSVuMZ7eSIC5PLqmlk
         W0FNZ2gEX95HVc5ub1aZ7QEA0mUBQkq4ZLa4jZdLZpc2yGmyDdTyu8w4zkFPu2t/1Msj
         Vs74xWv0qN1ABROc2JkZcGALuZPMBN1O+i7iV2Qd+1HE7VQS4oCOJYyFDiuGbEfrKH6x
         llWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
        fh=CitEhYmF6UC0oVO1I4wZMYQG6ym2gX400xgqFGAEQCw=;
        b=GLX0dlQsbHwUQvytBz1zitPUpXtQvIKR5UW0F6lDLe5VGy0hQbiVGV/akawfDvmazG
         a2e3JKUgILddckb1opQRs6wnsd4lX6y4n0kRQdKvg89m3LP/+iib9dRKwjLG0aYRG7EO
         GXLbAPg7jAivlsrD+Llee2D5OAm+yMnsmPtplpxTlJRFuBInxaI6Rc+13w/Yv1/rWHBt
         pV5ibFAGPLDdmFHJSwtg4wnnloLNt0YyM1dKP950GNldXd3UXMb4gt3ys5KHEwqHyNsQ
         jfOpeLZ9jPSLYdXHX5oejzbleMBSo0fdojqLWwv9x9DfNcRXuREUCruqfmMEjBLG/QQ/
         Lg3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766352; x=1794371152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
        b=NyYT572yiCVIxymQGlv8tJ8fyVMUD3PVocJ6lfrX4j8vOyaLRwp6ezM7AtutnQ5A48
         hxgPz+g03r9zNaKsaHFm9hk7uhQ10cylnqorPbqKqVF8S+Gh8mV+k7e3UsbQ/qUu2nA9
         JBntU9ZWNevKZc2kadM2uc2ncX1/skAobHBkl3+wpcogG90TI8IdSEzQd2/Pvxq55GgS
         KshO1YHSY5sDidi4IuafZGGq9r2QUggt238+3Db5fAIE1Q/XFi4sDMnUZamTlJ1BWmxG
         NtHoUlj7nMyrOmyCpmgdYly4pFykaWjGbaIIXPfsC+0M1LFLEoEo9ksc5/ThKG6YXPNb
         Bt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766352; x=1794371152;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
        b=TahSYuE4fSyPXSOcLFvz335R/puWri6OwJnlMnNrxotRakNAnnaQEJcGKn0o0QBDzE
         KMT7F9M5R14FSD6IAgTGOeQxofq/5Ym0Vx4cI5h9s9hQtCB2GBXO+AvKsqV+A79laz2Q
         aoPGPBNFqfCmU1w2DQeykiXDzjEyI27nzJywmEx5AfYowbGkpuuXXKBm3GJ+iGiZxEU5
         4fa7SSgCL247gYrnf2OmAJ/DhZZvUcDMkXZxyhUpB9mfaVe07KhxqGLxKqDHhxZkqa5u
         5OKM0Nx7lfn9BM9f4fItM4Wm7HbMcJHoGmUPzhCpYQLWx+mFWioY/TffThBd9IEzNh3d
         gctg==
X-Forwarded-Encrypted: i=1; AKwUvBz1Y/TW9qa0iloRrdycAiRoXp0u8wIamcu0tchtg8AduQBFCHctUb5ptUxeJAdatX3Bjwg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QS6YRZQhp6dKNmSU+g1SoIcjKhAi1QaxiJu0vSBAoJ2UEQ+23
	eIDch7jydp5TOJGFM8Xlqh9SpCbpqKNthf53ctu5ZYNcb8HHPTOKoJiEkcgGMraJwhTX0djOzbJ
	hf30MAcXRIJL/6Fo02dx8rNcn2dBIPHS3Ji+6Mcj4
X-Gm-Gg: AYBFou237s20wDoi9/uheaxALvNP0DJbgUXaXbcFR9JnlshOXpYDZRaWPKpDXpFvznm
	xVGA03iFmhTtsHJtJSoE5drsxWSCInnLpgY7K8OcnVvUcwAafyX//BkZ026hHJocbw2DM43BaB4
	JDw3WB/V2e2XbGbYM5ECXlwOMIFN0NrZa8Mx5dJRAsV7hsYi2EuZ1qGiQu/m7jfM/TLq4XukbHX
	7CbTG08FbFzxlvcK6aIn2V16oWUY+GhMUsx73XGTsKzRbRm2WloLneUiYd6JlvQyDPcF8nY6FND
	XGQa5dVja8bNHXYdLOMS2z4zq3J/6NwXjUJC9YNLq/IwKT5WkrnhBTztAsr9M3qp2xOjvBtaW1B
	9QkRsXT4tG7R/qwLuVq5cd84OecVVqbBUfFalRw==
X-Received: by 2002:a05:622b:d1:10b0:54b:648d:9ab5 with SMTP id
 d75a77b69052e-54b648d9cb2mr5349011cf.11.1793766351090; Tue, 03 Nov 2026
 20:25:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025215508.1237480-1-irogers@google.com> <20261025215508.1237480-2-irogers@google.com>
In-Reply-To: <20261025215508.1237480-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Nov 2026 20:25:39 -0800
X-Gm-Features: AclHuK-QZgMOvOFTv8qxkeUkqYgKRZ2Q1nM_6KHU_FH0WEU6VrqodwNE_FTWN88
Message-ID: <CAP-5=fW6gwOZpoVWSdDyi-kHHADHdy3g7oKREgCGn3SCO2Pb1A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf/core: Clamp deferred callchain entry count to
 fit u16 header.size
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 2:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> In perf_callchain_deferred_output(), if trace->nr is large enough that
> sizeof(deferred_event->event) + trace->nr * sizeof(u64) + id_header_size
> exceeds U16_MAX, header.size wraps while the output loop still writes
> all trace->nr entries into the ring buffer. Clamp nr per event (accountin=
g
> for event->id_header_size when sample_id_all is enabled) so the record
> never overflows u16 header.size.
>
> Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. +Steve and Masami

Thanks,
Ian

> ---
>  kernel/events/core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b43883a42566..37824ca7fe97 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10385,8 +10385,6 @@ struct perf_callchain_deferred_event {
>         struct {
>                 struct perf_event_header        header;
>                 u64                             cookie;
> -               u64                             nr;
> -               u64                             ips[];
>         } event;
>  };
>
> @@ -10395,12 +10393,19 @@ static void perf_callchain_deferred_output(stru=
ct perf_event *event, void *data)
>         struct perf_callchain_deferred_event *deferred_event =3D data;
>         struct perf_output_handle handle;
>         struct perf_sample_data sample;
> +       u64 nr =3D deferred_event->trace->nr;
> +       u16 size, id_size, max_payload;
>         int ret;
> -       u16 size =3D sizeof(deferred_event->event) + (deferred_event->tra=
ce->nr * sizeof(u64));
>
>         if (!event->attr.defer_output)
>                 return;
>
> +       id_size =3D event->attr.sample_id_all ? event->id_header_size : 0=
;
> +       max_payload =3D round_down(U16_MAX - sizeof(deferred_event->event=
) -
> +                                sizeof(u64) - id_size, sizeof(u64));
> +       nr =3D min_t(u64, nr, max_payload / sizeof(u64));
> +       size =3D sizeof(deferred_event->event) + sizeof(u64) + nr * sizeo=
f(u64);
> +
>         /* XXX do we really need sample_id_all for this ??? */
>         perf_event_header__init(&deferred_event->event.header, &sample,
>                                 PERF_RECORD_CALLCHAIN_DEFERRED,
> @@ -10414,8 +10419,10 @@ static void perf_callchain_deferred_output(struc=
t perf_event *event, void *data)
>                 return;
>
>         perf_output_put(&handle, deferred_event->event);
> -       for (int i =3D 0; i < deferred_event->trace->nr; i++) {
> +       perf_output_put(&handle, nr);
> +       for (u64 i =3D 0; i < nr; i++) {
>                 u64 entry =3D deferred_event->trace->entries[i];
> +
>                 perf_output_put(&handle, entry);
>         }
>         perf_event__output_id_sample(event, &handle, &sample);
> @@ -10430,7 +10437,6 @@ static void perf_unwind_deferred_callback(struct =
unwind_work *work,
>                 .trace =3D trace,
>                 .event =3D {
>                         .cookie =3D cookie,
> -                       .nr =3D trace->nr,
>                 },
>         };
>
> --
> 2.56.0.307.g5fe7bd680c-goog
>
