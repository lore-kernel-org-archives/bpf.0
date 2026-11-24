Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795561192;
	b=Bb5YcBjU5rzbni6/bKhpKAD5lT0+7SEQN63uAcCUmcYexlLWKTRTeIL1wawZP9Zw6+fy
	 edtkW1pd9iX4JOb0+agPbMIrVmvTjVJB54/FYV+f/0D+fHSBXT7+UoaxIJ3Hsjr3h8Qy5
	 dAMLhiftLn+G9mTjhe4az4lOIj+RLjWiKrAJdvtTCTO5WR5pJtP80LZ9on/AJfGa/ag/y
	 +7S6TaESHRWPmT3+JkwyqDOi+34+clGO0ETQ3/Sl4MxpZuv+uTyYqjWg3zdoM7g9hq74c
	 v4UqI+poGkf708O6wsJNwXmHO5DrXUofojdfNYJmVcgNthlzf6GuXXOO9q4kEoTrqVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LzRWA1G4Xrrw2rXAfNdHAR2eOL5j50wv+y3Px8Y6oIg=;
	b=ZHRVXz0bJd4D6Gui2hf77JzYtOSJs8zu9Yi6F6t7wp4nTDcmXsd0UBlJ18I5V6ih6N/D
	 Zi9yCF+4re8u5KcfuVsM6XIyq8wgdBJzPpfwQwWwa2IgS27rUMDYiaHlf4z6png911UsY
	 miasWuCH6tXR08EvuN/+qFkML4kNly8R06ArVbZ3WTYxG9rSwEGutqAMnxzio++XTRpKS
	 UVjyokVPurl++HFXPzD7RdkFSh04mNZqmSQOS/O7oSanMKXfQyblIKxrFcUh08PxydMS1
	 fMEaN/nvV73Aau5MN3Xvj5KXPufTs1AYlsqRrzpVVRHtusYt+Bg6JSl7wJ7LrtsbeUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zt9WfMnk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3E606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D3E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zt9WfMnk
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso4417828f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:59:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795561190; cv=none;
        d=google.com; s=arc-20260327;
        b=oirEdFfuU04VpsuRtJP0S8wC6oh6J0uETGx4YiLQZf7R0ziIGHAmzX1MS4oHaZ7KKT
         JKBPMZ0HZB5M25dVzouY+/W5cy+p7KWa3XcgRuXMOrgRzE79x2NCbXVtgqbSY3g9mYpj
         oh8SRCd3KfIRYjfEiX/nEzpxgf9L388qBptXOCGEYxXLuJow5Wgso4Gj7v4vP6/WIPto
         tptABOrI0duHEOLsHRREgmkHUrjrGpQ5APHIO8XQXovbcFjmP+zjg7WkDXwAFNJBfi04
         qkRTrAzU8+ll28nlhxUUP/Riw9pwEapeXiuGHJclaoANIREKnC6ayBqFZw+QexiTwsjS
         l1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LzRWA1G4Xrrw2rXAfNdHAR2eOL5j50wv+y3Px8Y6oIg=;
        fh=WkdjIrxBfH5ed2ta2BSU88j2RUESv69G1Nx4GAVlO54=;
        b=kRKdJlRTDkB11pq0QxbxIzxSYpBI6+VH/aUtxFgT2YCJN4vOfKkyq8bBZjrmitsKai
         sahDeTzFoAZ6hJEpEMsxwb+vu1n1Zcj2zZS5XdrB8B4Fu5eDyHHQYV0F7lSgkOPWHZTv
         o2KOdEo3Hp8lOFJETN9FPkVuETshNaU3oxYu//SCyPg1jwb3FFG8ArrKSbrChuYHus5T
         s5sc34ekVHqh+uTZ+Y3qI9+WVj397imaL7Mn2BN5/wasYyMEdkZbV/5TkAnE8FZUYwNT
         IYxM8Ep78POUP8RkDDAFHFy7ZLy6yM513m9Ogy09eF61txoblKU0sVMtT8B/wMWlZLC0
         dFQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795561190; x=1796165990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LzRWA1G4Xrrw2rXAfNdHAR2eOL5j50wv+y3Px8Y6oIg=;
        b=zt9WfMnkAoAYTAlQJfqZN+VhandnJpd2KucygZH5tmM4RcZ+TAuHWkMhGoFrdmCeI+
         v40wJZuavuDrqHBU927zWslnmlPbforW9vaCQRn33zDe5XXshZI4XoUEwCR7d+XgOe73
         ykVU6uQYOlhO/HAW393WStULfYJGPJIkOUgA2FAjkj0WKI+PprXl3Zt3qfRDBQ4xhLhl
         alDPhd9CZWtK0d0i5RDozhrFnrzU39lvlVsvfAB/lipaGFfMYq3Ziyuo8eMaggoVHAyF
         brOiUY27yXvIDXSWNpnssWSkoNSzPZlGGfWg6mLp1SNP96UCWPggfWVhev0FFRv7LIIi
         EEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795561190; x=1796165990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzRWA1G4Xrrw2rXAfNdHAR2eOL5j50wv+y3Px8Y6oIg=;
        b=POqw9yvPhDQQ6HbO1G/g3sW53JDLIs0Q6gyPL4mjzrfTJAloZHHvByHlGH5v+W7m/h
         4+Sg5mo2p4wakmk9+MUA0sbTBbWo83zdcC6gervDJzyHgpttoWmRdjriAgqpuweBWlIH
         HOJEE5batkUZUetwZeqc5LDAowZ3m+IGRBnnlcfEe2d93b0Ulw0Y5wxgRkdccmGf0JJx
         bR2uV/guzwsxS/NNCW8IvERP7aaQRxJHGhGytAwsg8YbhNLY+Sp4vMEDXrEZii9Uctwd
         4czkkq7HG+w9QjwX46ODHlMI82ykNMivy36glX+aI+0ruQWCYIm6GR00dAecwmbcPM3C
         uWrQ==
X-Gm-Message-State: APuU4Z8OjT1QliytmP6hBVzseXH8RR1QyYhbE76aedPltjdsOVIeHko6
	Hk4g5GLv4FBrhqwlFw+DTU4OELD1FMvpfGUeM2EG3VdA1hjPmofLa8rOVpvgAV5k70d6/j/ven/
	nsyEjFbiAyWCEsiE9+EP9d+i+ZuqaO0c=
X-Gm-Gg: AZFdTZfGROeNsr0qbwaZZ9rVXkTSr9MnRKbTsNEpAxdanqsrJgbi3lcn93tPu3FxUco
	kUFqCb7WpSiVWT2OcNj1F/w/iu76E7gYHHmD+TVZRiCOWSkY5u8Q07o4HJDrREW6y09Y/dnDnz6
	4b7aaw7xOCGY5KMH1cGeVdue3KhrpKGqziuXq0HBxzY7OMBJbkKM+INuqEpBf0p9BdrnJNTaHod
	1RcF7ii4tH6XkUFEPy8dboOxfPlQQV61ZGK4oY/UFfQHPObqr17cgRquvaUqhxkfpES10f90Zqq
	wDz8sbTrK38akAe5UwvaaD2sK+TCDTVbmIEsXkOwVa4ZlJOoYUAQuvkAYbZk6vrV4xQapFVcGdC
	ilJrldj184UD5yhhoqEPJzctS9EpUld+01Et8WrYwfTfeh0LRagL2Uw8IT8HaIhBMf4cOQt8NaE
	MhfDnhuEnhgdasaN2HRw==
X-Received: by 2002:a05:6000:45c7:b0:48e:2448:ea23 with SMTP id
 ffacd0b85a97d-4abb5144bd2mr18454517f8f.55.1795561190430; Tue, 24 Nov 2026
 14:59:50 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOu3gNgXcryEHSjSxW7u5Nx-RBj9Bfn+h_YZv5fGvD+0arGvBQ@mail.gmail.com>
In-Reply-To: <CAOu3gNgXcryEHSjSxW7u5Nx-RBj9Bfn+h_YZv5fGvD+0arGvBQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 14:59:39 -0800
X-Gm-Features: Aa3M54qmhr_e5b8WU_CNC_aeHJb3liCrtPFPxsrmgg-eCoq_gS_9AzAvg5SIgjA
Message-ID: <CAEf4BzarLoswH7ZTVsxnTq4D_NE_RZu3khDEzzyjs_2bbGFboA@mail.gmail.com>
Subject: Re: Reviving manual (lazy) BPF map creation discussion
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Slava Imameev <slava.imameev@crowdstrike.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 7:38=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> Hello.
>
> Now that manual loading of BPF programs has been merged [2], we would
> like to revive the discussion about doing the same for BPF maps, and to
> ask whether this could also be a topic for LSF/MM/BPF 2027
> [3].
>
> Where we left off
> -----------------
>
> In January 2025 we posted an RFC [1] that let libbpf load and attach
> selected programs after the bpf_object is loaded. The discussion also
> touched on applying the same approach to BPF maps, and a number of
> objections were raised on both the program and the map side.
>
> The program side was reworked over the following year to address those
> objections, into a per-program load strategy (DISABLED/AUTO/MANUAL), a
> SEC("!...") declarative form, and a veristat conversion, and was merged
> [2]. The map side is what we would like to discuss further.
>
> The problem
> -----------
>
> Today bpf_object__prepare() creates every map of the object. A
> MANUAL/DISABLED program that is not yet or never loaded on a given system
> therefore still has its maps allocated in the kernel. For a large
> modular object this is a lot of wasted kernel memory, and in a
> memory-constrained environment it can even needlessly prevent the
> object from loading.
>
> Real-world use
> --------------
>
> We have been working on this internally since the 2025 discussion, and
> have been running it in production in our internal libbpf fork. Our
> endpoint protection agent ships one large BPF object whose programs
> depend on optional features, so the set of programs to load is decided
> at run time. Manual program loading already reduced the number of
> loaded programs and hence the total load time.
>
> Creating maps lazily, only when a program that uses them is loaded, is
> what allowed us to run the agent on customer systems with very tight
> memory limits, such as containers, where kernel memory spent on unused
> maps was a real cost. For one customer configuration, we see a 12%
> reduction in kernel memory used by our agent on that system. We think
> the same use case would apply to other memory-constrained environments,
> such as embedded systems.
>
> What we are working on now
> --------------------------
>
> We are reworking the fork implementation to address some of the points
> raised during that original discussion:
>
>   - libbpf never unloads or re-creates a map. Once created, a map lives
>     until bpf_object__close(), and the kernel's refcounting does the
>     rest.
>
>   - It follows the staged preparation suggested in that discussion:
>     parse the ELF and relocate, then create maps, then load programs.
>     For a MANUAL map, map creation becomes a deferred step coupled to
>     the manual program loading that references it. After the ELF is
>     parsed and relocated, nothing is created in the kernel for it, and
>     the map is created only when a program that uses it is loaded. For
>     AUTO and DISABLED maps the behavior stays unchanged from the
>     current one.
>
>   - The choice is per map, a three-state setting (DISABLED, AUTO,
>     MANUAL) mirroring the per-program load strategy, with the default
>     unchanged: maps are created at load, as today.
>
> We would like to post the libbpf series for more detailed discussion and
> to get feedback on the actual code.

makes sense, but please do analyze thoroughly all the different edge
cases that could be broken because of this

>
> LSF/MM/BPF
> ----------
>
> We would also like to know whether this could be a good topic for the
> BPF track at LSF/MM/BPF 2027. Invitation requests are due January 27,
> 2027 [3]. If it is a good candidate, we will send the formal
> [LSF/MM/BPF TOPIC] proposal to lsf-pc, with the topics we would like to
> discuss being:
>
>   - A recap of manual program loading and its application in real use
>     cases.
>   - Our work on lazy map creation, and receiving feedback on it.
>   - Whether memory savings of this kind matter to other libbpf users.
>
> Thanks!
>
> [1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crow=
dstrike.com/
> [2] https://lore.kernel.org/bpf/20261029223348.3730738-1-andrey.grodzovsk=
y@crowdstrike.com/
> [3] https://lore.kernel.org/bpf/20261119-lsfmm-2027-cfp-b7edcf7eee48@brau=
ner/
