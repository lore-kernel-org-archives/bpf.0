Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378135CBD6
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530535; cv=none; b=cTmynEuTq2mHKuIcVH8VFJKGHaPEnZ7MJ/x62V1duCuYFlRWAvNb0qPT5s4yTieUPj6X29Pd6nD5FZr3deJSpyuJ97J+d1SdvsuekvHqaoBR4EEFfte6hiV+fuOxqg+cm+KY6o6F7jSOusAcafSg+aE2vWb90kaCzActhSAAoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530535; c=relaxed/simple;
	bh=XzumbK+bcu3fqR36UKRZRGrtN/og5725vQ0Oh0QLSOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMjG3Db+6QCRIajyO2PEUuYC5b7V/8JEybTNfmAxr9YESScaALITyKET3ac2/37PdRHByiM32w3ClwYzQXMcBGsyCGL2ZlEsxJBdWwBSo6sY+wHfT5b1qn2s+8eueyKybcH4+902DA1XMI2OwF8Hh9N1ui5AAfDq2LndMH4JPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJo1KxYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJo1KxYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050E5C2BC9E
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530535;
	bh=XzumbK+bcu3fqR36UKRZRGrtN/og5725vQ0Oh0QLSOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OJo1KxYVIBjuQhkIAwA2nGhhz+u6yU9zGamtuX4Ly5XUd5J+5WdMF1A2RAWRvvZHt
	 2Tp+DzyIox8FRPliODm2U6Vu+6J0Els1lrHOHYo6DBYzLNRiov0h6oKG09sOT2Dkdf
	 w8GnVQnH1pVTH5jamWfgC85U8CoQSMRazxURRf70V5+dZBOygwuE4iXIZWzOlkvPOO
	 0X/Q1eJu719ogIoSPmdQlVkRtvEwk3YlqqaD58vu6MbagP85VTUGSkiJ+byeLvoEMK
	 GnlDa2oTx5DWT0sxVtHcJ2/KfrrBf5oKn3vHAzyZ70sTLPwbxEXBZ6NSZGlK0rC04y
	 ctbcrerZfbZGg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662cb4bef90so1605476eaf.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 08:15:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJQzKxbnsASzZ+v8BRmSQpFNVSP1+sle2RmUOer55QQXgoMxCv7Im9Oxp+ziD2S5QVqv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBBIkLy72iTJyTOt3lb6xil8gJFGnrGBjO0OtYRdzsqUnte0j
	hCPmdRZ3cYkeK8n+BW6ellBKHSc9mlbOpeyLj9FWXvscoLlVqZfCdotFWPepyFaScLbuXeq8jPl
	fTzsKsEdnPEq+1PpKeRFyuCfz2cKKV7o=
X-Received: by 2002:a4a:e1b4:0:b0:662:f543:5d3b with SMTP id
 006d021491bc7-662f54363afmr525037eaf.81.1769530533808; Tue, 27 Jan 2026
 08:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com> <20260124012133.2451708-2-wusamuel@google.com>
In-Reply-To: <20260124012133.2451708-2-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:15:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
X-Gm-Features: AZwV_QhA2857ovslXCLqyKjCKicGjIcJQZ5bsHbrqIJ3xN0iiE30rvHqvTrjTj8
Message-ID: <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] PM: wakeup: Handle empty list in wakeup_sources_walk
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 2:22=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> In the case of an empty wakeup_sources list, wakeup_sources_walk_start()
> will return an invalid but non-NULL address. This also affects wrappers
> of the aforementioned function, like for_each_wakeup_source().
>
> This patch updates wakeup_sources_walk_start() to return NULL in case of
> an empty list.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/base/power/wakeup.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 1e1a0e7eeac5..e69033d16fba 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
>   */
>  struct wakeup_source *wakeup_sources_walk_start(void)
>  {
> -       struct list_head *ws_head =3D &wakeup_sources;
> -
> -       return list_entry_rcu(ws_head->next, struct wakeup_source, entry)=
;
> +       return list_first_or_null_rcu(&wakeup_sources, struct wakeup_sour=
ce, entry);
>  }
>  EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
>
> --

This looks like a fix for the for_each_wakeup_source() users.

I can apply it without the next two patches.
