Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794087143;
	b=DYw8CkV7d2TOgiZe2DKvqjQpQWEEs14QFvy/K7/7gla10rw7CjKGBUeyvdgTTzxmXCuD
	 QcQIiP3QOilFxLeDd+AweOqaHskZPj5tSM4zoK7VP566zISOdBdMBZAzvWbYlMR/QbwRF
	 mZx8Qoi8Yeqc31soy6DEGaLzozyqdlJZLKuMWzCrV/ehR+6lioZwbFi7znJEOBD5hLa0q
	 b/JnjJaXdY90t9hUXJnMlmNbAOyuQSdn7n5/VpTmUkFOLJXGSWsPoNwKXq/CV+ksqTJuE
	 vu+vwroYgpnUYwJVHVk5WAlWAAGmX2pLRP85O13vJ6OBCLJLuS2bKKTrnqAfakg6JzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fAClDdVa5D4N7PoudPRt5yaNj6K+a1j7ORktYRxzeHM=;
	b=pCioUML0XfSObPADwRCiwfnnZPwXkJB79CXDRkhI42APgCWdcXOnDKaCfzhbHBGgSIoa
	 n6WBpV2oBvFnlVY1Bcr9WEnNl2+HbE9BH1bvVAmVom2wCKfu+kflCULpg8X7AixPzloQd
	 3asNnA1WgqUYmKUbB9Ef9xeM2PVTa4hBHCLu8Wa7VH1Fw183d2rHLCwkppbYTeaZofmhC
	 0LFeCcczDwCI45jCsbXzQ/jhaW00xp3dR/DlRDAZ6CLPffIgqp8rLsB8mWpWB2m4N8URY
	 BVoQoT/HLkuUVaVj/zuquEpmju64HF+afhQO3ntLqLZV2QTUWiLN77fVimhOMGvbxIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=FE4M6Z2d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56A606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 21:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C56A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=FE4M6Z2d
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3afc7b51abfso6910a91.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 13:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794087142; cv=none;
        d=google.com; s=arc-20260327;
        b=RkpaKhmmFTj8vezVL4UOKyHcNz8XOuLTI79IuI+4G4Md0S9aKavnoZOd25jnI/F3mm
         DhFQFFKgpSMzLahDIk4dZsTwHDVyPKcw0jfwwp2Ot7f03+ouUCpEOHRzog5z8BO+1h5+
         M9fHHUM13uUuiikWcGePEM3hN0eGxxVYg7zMI4znL/hGdw+TWWS7iQwwPRAw8xQF+ptA
         39qNrD+VjyVl6f8MaTnlo6jaU92RoCnwm0acUBR6txNAIvQ0ROcviE0CfQtWsTVgANNx
         FHnorYchizdpk+nUO8DRStocKlAPMFDzw5B7YOoLd7QwKb6smUI1mNZj3CILAgWxegwJ
         VJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fAClDdVa5D4N7PoudPRt5yaNj6K+a1j7ORktYRxzeHM=;
        fh=0Mf5Pp6OLq76vbj3snaqXv1QPoRArMhKaR2Fpmwl6Vw=;
        b=Djw8UJ0N8KkwzkcVQ0eoHjn4O2bO4dxsOE+POuJkiSblQMieCf8WKOh80IRX1hwBOn
         bGLCu3y9G5c/XoUeEQYCKBk/fvS8FxX+ZyAZ/Z+Kl9cVKjlUZJChVEDXH41pA3E+j4JH
         pVRfTK0bQE9F+ekEPz66F4m4+IYj08xXnjRM4u+NwIZiTncviaApyq2UiZLp0RlONfLT
         uDRh3GM+LZVFUAckCqjHF1B+lCNyTc64zdbTweF77WSXnHiWkVoGWjyYMD4rAzlzoF7G
         3NSzNQao///Yur5MHjGAFYKTmFZ81TdRnNYlInXVk0VNNaGjW3T2TiFFQqZCuS3K8Ihu
         /f6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1794087142; x=1794691942; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAClDdVa5D4N7PoudPRt5yaNj6K+a1j7ORktYRxzeHM=;
        b=FE4M6Z2dKnhEWsud6rEQ6kWuD+HailDfVd/JSa0GXgCdcPn/l2WszEIk9XGPSqeT0q
         GbQ8fn0qxiCAjHSNLQ8UEr47fIuqLuWD9yVjm1xLIt14/XsoVbxZC0+NWjeXjUu9SxyH
         6eQKrG1KNgkAACTm8Bcor7Ml+W5azJissuwxAA/4bqBbsvRDWR8viHkGdrYgmiJ1kzwg
         xl84zqI8urOELJQ9lWk/bskTrvjGrog+67v8Y2Mtp+BRPny0bsTNNQSG7QSZeVkfxRbI
         9oDRmImLfydYBBDo4Ndiptq+f+JzZzTM9nGBU1/WVhium6lA7JGNpiDMmPpzKWwDIurI
         iGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794087142; x=1794691942;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fAClDdVa5D4N7PoudPRt5yaNj6K+a1j7ORktYRxzeHM=;
        b=czRqK3hi6/DtKYhf4el7Em1cRyd0tNtzuympDnet6CkRp32fhu2lFi5/HV8Y3QhQHD
         qjktcmBF4vUoxwY4Xc3spPUxQ8tW9xOK1dOgE8tanqPUmMz6A7CRxFUscY8um8IwTA8z
         vsHtuSPANnvse3H9fcZg46x9UaqykGIbmDMpGxgs3pIPgP6aq5cDyNnCB0ATOCfB3Ol3
         oGZzw+DH86HT5pJ5qhB5R7Hxgy/huN58tL6ORwr0dWL9O3R32rHqPTOmRbJ4kh0Tbe+y
         RRrNEq1b4MxQfsWowD29+wB7eRYi61MOq1+eeI0ZTX8URzYFVHSXS9p5D/I7y6P5IodV
         CCXA==
X-Forwarded-Encrypted: i=1; AL+hErEDSTG4etTW//NDkq19aHHGMKifH+hqC45MVtrcErGe5EN+MH8xcksM0XcvRKrEohm8fzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zzpLYJ7TIcyAEks/9vTK6HbYYbGfjkT4mMRZHmCOpNEe6Z6Sz
	d2JT68LsX+CU/vRbsUycVs1kUywHnqta5AUoPl4UjcQsFS6GxDpG3Grop7PVqGdGDBrvPHBOmEp
	lrSasP7DivR/+J8gNn1hego6GmwzM3C8ClT/H1Z/7dA==
X-Gm-Gg: AYBFou2vVwZVNo/Oqktt1xDLj4Nw21rNkVkGnaS8TRKpBwKdk2Ti9JFuHX4HSjJdR5H
	LtyP53iN/IijJb4U6ab9IZhNu360fyPekhPJJliHba7b9BlY88EfuzjFVaVQCmINHaIOkcyw+w8
	YpnUQc097lXHeQSZdFysZWOQMQVSQzsTkPwHFdxT7Ab7H44hmfY+oHjsHiQ6r4+bKWmFZyWUzGp
	P4vvdBU5VX1GUD6yIFcqjEL6Ye05pokV2jLhr1Ty5OzBhIKkDDUawMP3xXtvYATtz+xATdhxYyG
	dgkZ79AxEmfqnP0pWnGNwj17539Hb2laWXO9SD8AYv5kjpX9C45YEJvC4RieoZhzz9jINVc/Gk2
	qhBP3ftaH4/8n0uICmJ6pIwk/uepfC8xZDg==
X-Received: by 2002:a17:90b:388d:b0:3a8:9db2:a59 with SMTP id
 98e67ed59e1d1-3b0db013fbamr10127781a91.0.1794087141883; Sat, 07 Nov 2026
 13:32:21 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
 <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com> <CAPnbwjpQBR-KHwOMG2bo1uhdp22ZW_O5sUj3=vjazVu=Rdnb7A@mail.gmail.com>
 <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com> <CAPnbwjrX-ywbcgNQSZKE2jiggEOSVCRVw9OLfaksihiVSCoqvw@mail.gmail.com>
 <CAEf4Bza0XDMTxxZeukwRXjvoOOruY49q66xBXnYnuncbeo_Oiw@mail.gmail.com>
In-Reply-To: <CAEf4Bza0XDMTxxZeukwRXjvoOOruY49q66xBXnYnuncbeo_Oiw@mail.gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Sat, 7 Nov 2026 23:32:27 +0200
X-Gm-Features: AclHuK8VaELpN_xVEw5v6aYLhDqxLEvH5z7CzGWzlbUdtSKDEKr2aOOzYpF-uoo
Message-ID: <CAPnbwjpZRmzJFXDa=thc188ZNru2xCBrCsc1WO5mNDzRRQZJBg@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, JP Kobryn <jp.kobryn@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 6, 2026 at 2:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> hm, funny how AI figured out run_ctx, but didn't figure out that we
> already chain them and we do have that pointer in current->bpf_ctx...

right, good point, v2 would walk the existing current->bpf_ctx chain instead of
adding a new task_struct pointer

> That's all to say that I don't think there is a need to keep
> guarantees. If per-cpu map is used naively today it works ok most of
> the time, but not all of the time.

Alexei was concerned about existing progs relying on it.

> Perhaps we should just get rid of that whole per-program recursion
> protection and just make sure that a) BPF program can protect itself,
> if necessary

If we drop the recursion check and go with a), protection is up to
each bpf program author, so wouldn't a careless one be able to panic the
kernel? A prog as simple as this one triggers itself:

struct {
      __uint(type, BPF_MAP_TYPE_HASH);
      __uint(max_entries, 1);
      __type(key, int);
      __type(value, long);
} m SEC(".maps");

SEC("fentry/htab_map_delete_elem")
int on_delete(__u64 *ctx)
{
      int k = 0;

      if ((void *)ctx[0] == (void *)&m)
              bpf_map_delete_elem(&m, &k);
      return 0;
}

Without the check it would keep going until the stack overflows

Mike
