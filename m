Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BE14D29E
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558700; cv=none; b=Z/k9KSh3aM++8VfTo1mFBodozu5VJTcqTD+GqTreI9p1eaGsKh3FemrZiNqKpS32SK6L6U5Q5rVwJ6O7t6kd+xt+t5kC2ZSpuqkwcPIRJSqUsu9JvDNKf4tMjknPI96swdfAY4HgJjS/Cq/NC0X9ybEZcMAiD5SpVwUmho3sHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558700; c=relaxed/simple;
	bh=e3Lcd69G986kj08pgCrSZ/wAzOic52nCyAkKjwk+KDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvRXXzH5kYBPQr9ij3Zy5F7c7DgDQksvyA6peSGEBTgCHiQ+n9bEMt/jyARO0d+zIWvhxPWeBGZCr8CV01T3TlbjtnvPCjoNCxaDwV7Ae43qH5LAcfHkpiaMSDpLsELJDWhz6iwqj9hEz53gEZ3YnzPz1zu0vV8E7LtY3za9rzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkZVzSTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkZVzSTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35498C433F1
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558700;
	bh=e3Lcd69G986kj08pgCrSZ/wAzOic52nCyAkKjwk+KDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JkZVzSTeWEahQWeWb6+m52p2noZUmdZkwB4Ic0xJVaEcfJT0GJKtoD3ChkCRtRP3i
	 WZDCDTWGC4S7zAPOydtsnJLeh7kyKxSqx/QXi4BwSn8isecj5UwIzlheXAD9vcFnd+
	 /zotMC0lez1LnvsAcloU426eNGaCgbUWtOqE84Mxsxdv0VpsuOFk6WlmJJ9kccnrUj
	 77pPHSjUI64bOQKvEqk4SwyATXK9bcvNVtjs7kEPz+IY/Eogds4BysJbn9WrBbTVkk
	 sU7EIQRuhyUbLhqLqaJXoTektDIK++sNkjLKDSdbWwuJCYHf2nGfhdTe3GJ4JbuQ1o
	 upJue8Cy8f9YQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5159f9de7fbso5601350e87.1
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 09:58:20 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw9RKJ3dAlRnZqNrFEy7G4EXOQ5rP4MnF3kDdlS8kdd4/5eS8qv
	AeUTO0kmXkyVS/2qyiMtsFkTl0LigQuY3Ms/P2teYilAPTuBTlv/XZDOEBGflz/o2p2Eaf9V0vZ
	fUkMwBdfW2PmGeL9XiIiSzFlOe1mVfCLrBhgi
X-Google-Smtp-Source: AGHT+IHQlt54mycQgog/7Y08ydqojSca+q51mnt1uD5EEA1vs1eldPPib/oMjxu4F+6TkTvJxPtwCzf3a0UjPONHAqc=
X-Received: by 2002:a05:6512:70d:b0:513:c97c:d5f with SMTP id
 b13-20020a056512070d00b00513c97c0d5fmr45922lfs.12.1711558698536; Wed, 27 Mar
 2024 09:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgMhWF_egdYF8t4D@google.com> <1AA4DC87-5BBB-427E-BABD-263B00FAF1D4@kernel.org>
In-Reply-To: <1AA4DC87-5BBB-427E-BABD-263B00FAF1D4@kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 27 Mar 2024 17:58:07 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5_v=0CSu-xYyvrjduEdAryAdOx1mJA9NZPvhHWj0PPeg@mail.gmail.com>
Message-ID: <CACYkzJ5_v=0CSu-xYyvrjduEdAryAdOx1mJA9NZPvhHWj0PPeg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: update BPF LSM designated reviewer list
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	revest@chromium.org, jackmanb@chromium.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:48=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
>
>
> > On 26 Mar 2024, at 20:50, Matt Bobrowski <mattbobrowski@google.com> wro=
te:
> >
> > Adding myself in place of both Brendan and Florent as both have since
> > moved on from working on the BPF LSM and will no longer be devoting
> > their time to maintaining the BPF LSM.
> >
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
>
> Acked-by: KP Singh <kpsingh@kernel.org <mailto:kpsingh@kernel.org>>

Acked-by: KP Singh <kpsingh@kernel.org>

My bad. Here's it again.
