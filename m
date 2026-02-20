Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193819DF8D
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627738; cv=pass; b=o8JCwaxXlsobevJKl09ZJXgX2nf7bH7JVxAV0A4PXC9Ji2D7I1r8eQkNOCTEVIl1q2SXlxYEjdassqfhbzAXWludjeJ9MlRZEnuV4ogV4IOUTKmSsLk+U5ttVLtHKO/BsyLjnYyJ46UgI7YZ5icFurHtQHf/g6I59oIPnib1Fv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627738; c=relaxed/simple;
	bh=Zk0TkRoGfJVRXA/Xt0PgtI4eew4BSdOTfIpj5z5Fnes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR21hmNT6eSSGbmywj/YfNuISdEYdV2/q8Izrsnoq7zaGUTdj3T0fJKTrfXdsOFrI7FGzPCnCqY7dJusqIoqOvyj7lm/7b8YuZWdpi8gXeLExaFdeD3bPusfJjoXphX6XaH/BghcrrKJ73Fxfq97jcB5mIgdEgFpIiePs3tePi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSCa1ph9; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSCa1ph9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-436e8758b91so1907341f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:48:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771627736; cv=none;
        d=google.com; s=arc-20240605;
        b=eznFSl/uKUrfQMISB2sSoVanTr7EL6qXDnCqtq46qBu22itYxgfiiW7F4lRIDH+NE7
         rRU6tcpPRkx9WiM9m+w78dZElPyhbp4w+QxnRn2VRqoyNENQVsZ3Ut322zu3DDE9Oqjk
         qgElaorB0C1zDQXimq/MYJUAspckvkheB/9wYKylmTeVaI8lne9hclw+VvPmHfm3Cfj/
         tWkAmybt+uRZOiHZ68BdK0ggBsHzY6Oq7hSe0FUV6wA20ADmOPtS83QKAu9f/z53mpNa
         YWpnDQRkJST3zqGDF69pEUjLK8aA5nth4tV/kzl3tSYThWJAIYLytETrou57vDUO4K5k
         EDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hvVSN1bBI2OWfGQjoSdR4/GA9VFoz8O0r7dIRH0tiJI=;
        fh=AEU61cLxum+kXVi0izUQVJgEb5jnfIlexyFisEqSqR4=;
        b=Er8CqlOaK5i5sUcprQNGht3rr9OKyo/WhNxQEnJj2RwvqoOUMm2XFkLbACQabTtVXE
         GeTm7aP9Wkzxc339Gd/XIDqBpCv9trw9HLZLWek813Am7XHG2GbyfGE/ZBCfk+6qg8w8
         OIUMrAqoVDTqclqJgPjATQa7BXYSucoa0MvG6/dttvTV/51jsB8/3FRI0mejFDYK3u43
         odVzKH++1VxqXPUI2ZomE+H69ggXx5A8W2uKCBCGwtSPCb3Uuhlbi4sIA0oXJgfAQfAU
         d7o9W5M0wfaVmW0F900ELkR968THuvMTNvKyYvwShvIajIrtvlfqrHDLpZVb3+cXTKk7
         GCUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771627736; x=1772232536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvVSN1bBI2OWfGQjoSdR4/GA9VFoz8O0r7dIRH0tiJI=;
        b=BSCa1ph9y6dmUlS3o7sEucQY1gA7m0nJ/0wqY6jiP7Fc41YGRkmxXuk/P9TfFkjGey
         GAwWao8T5wq2ZZtLMRnnOKVCA7gDFuYs9LX+Ewj74aIPBLNt2JgZe7arz0fUmQG76Db7
         aqfhDxl8mMguAbeY/l5txrEUbhf9D1iySOskxet45cajDzOhV7PaEieCatWhfnRMtzOA
         F84iUnKDFq369L2D7xKSmKGMseroSfP6QrnreZiRsIoiBhXg9KioKFsO1OluJcVEyCBZ
         aS6B/Kdspqk9OxuUeQdRRBttviWyhGay2BN8AP4oKH/CiNGKU/SGIuEsfNHxphRoZ4U7
         Bt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627736; x=1772232536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvVSN1bBI2OWfGQjoSdR4/GA9VFoz8O0r7dIRH0tiJI=;
        b=eQ3ARiHmCNprRCDlpKtW4aTM3bQMPcWel8iMNqNfkqSQMUiU1tWJ1SzMOPFZDCGlob
         8ii48Mz7HHjy6kIpucSHkcekTgJ4iFaNVdfScro45AKseNDcgiX+EJOgYskrfPeuAfM7
         xZ2yzzyEgPxRUcJcaoWAyavGVIk3YGPsTWHO8yNxWU/JN/2gNMzlksQ7LP0ql3U+fWj6
         A1gPYyL78ysgNTcOddn+F1ZgFHFMyM9SLP2+vEyiDVkmpRtvTz4y8QoUbhVLQJyf8eJS
         LSBwB6w66pzVLK/KP8YSQyEO7AYpkbvtu/zQEzvhlvfqY7oyiKT56GNTwhVLqi1KcP40
         NPog==
X-Gm-Message-State: AOJu0YxgEgP5dkqIY6PymH7s38CL5g/PWr7MVC3rd5Fl0BBHqLuAgPRR
	Zzb4ctg517EBE12KnnP8HhqkaaWTL6IbXwTI7gtcjrhzXQ2CzV4Gko93dL2IViLs692W3GBuKhg
	bJ15nn67pX3VNcPTMtt+ZfZvrWOF9Knw0jg==
X-Gm-Gg: AZuq6aLAqsV15sn+Q9qTjPPdGKktuWCV2jQ7RgHz7zMEnXrGDl6acB1VAzK48KBjdvA
	z1HeV357EAjBbUjWZDi9ccfVXYsPI56N0ay8d4+HCLB/EjFrqE1vhkAB8PhyrUycFTsrKD2wM3H
	AesVte0WyS4B5dlnGMCWXTiwuum0DxA3xHvSqX+KsNN/xqr0dbVm98veAkEOKLfp/95iaYOp99n
	HE+qpkwtP+4vO1tK9qtl6mzkIcUiRrQ7ss0Srh1BxdU9PlJuPt/b3PppP9N5dz1pY8P8344JJZO
	FW32E8EUknM4IacnJ2oP83ByMSFfskbDhxWrRuaBlyTAkajhZvoaWwh7Kqqu/RpJ9KtNF0qUdFj
	aQn4SFgXpHR2YGd6iq4tX5hSnwQ==
X-Received: by 2002:a05:6000:25c2:b0:435:b7ca:7521 with SMTP id
 ffacd0b85a97d-4396f15b019mr2566435f8f.15.1771627735580; Fri, 20 Feb 2026
 14:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
In-Reply-To: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 14:48:44 -0800
X-Gm-Features: AaiRm523CpdbVxcWFlxA4ENEC6v7QEZI_dhCgR8cUwCJKYqQVHleDKqGFrwR9I8
Message-ID: <CAADnVQJFHzGQX0xh5pSVm1AKH=ONM4NYRnv=+qdWOAW4PmrVQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] libbpf: Add bpf_program__clone() for
 individual program loading
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 11:18=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> This series adds bpf_program__clone() to libbpf and converts veristat to
> use it, replacing the costly per-program object re-opening pattern.
>
> veristat needs to load each BPF program in isolation to collect
> per-program verification statistics. Previously it achieved this by
> opening a fresh bpf_object for every program, disabling autoload on all
> but the target, and loading the whole object. For object files with many
> programs this meant repeating ELF parsing and BTF processing N times.
>
> Patch 1 introduces bpf_program__clone(), which loads a single program
> from a prepared object into the kernel and returns an fd owned by the
> caller. It resolves BTF attach targets, fills in func/line info,
> fd_array, and other load parameters from the prepared object
> automatically, while letting callers override any field via
> bpf_prog_load_opts.
>
> Patch 2 converts veristat to prepare the object once and clone each
> program individually, eliminating redundant work.
>
> Performance
> Tested on selftests: 918 objects, ~4270 programs:
>  - Wall time:   36.88s -> 23.18s (37% faster)
>  - User time:   20.80s -> 16.07s (23% faster)
>  - Kernel time: 12.07s ->  6.06s (50% faster)
>
> Per-program loading also improves coverage: 83 programs that previously
> failed now succeed.

Wait what? How is that possible?
