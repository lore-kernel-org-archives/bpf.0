Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3B2DBF47
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847776; cv=pass; b=o4W1KGwzBPuwP/37ow0pREVezURDU4ynr9cZ4LBSuVVOkdZ2crF85KqFdCT7cq3NbLDS3V3u1j3sOXp63qfSlip7QSj6rcx1OBXQzVrFXAaOW4SoOFCuw6VXDWktaNqFXmwBGhWWbMgjtU+az0j4jVu0hK99kVC3rw+2BY4HIms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847776; c=relaxed/simple;
	bh=MCKn6bEL6Dn/Q3LFAkOG1sZ0TtxpcL9reFjMR9+R7Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTNUapBR7JO946miFfd3VHUQC05LhQAVLEXaOvF3Lz+Jns6ofvRjY+D94v+oSfl8mRFkMfObMVO/6ggaArZxcowJfCBTsaCmBxLqmNQor7RFsVc59lRkbvDry1CP39KI3N68ZtuSpHZRSGJv1JB6lBtT/e7CORXJ8GGYeAslCIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWEwSoOh; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWEwSoOh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359249bbacso976240f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847774; cv=none;
        d=google.com; s=arc-20240605;
        b=JJ6cjhmdUhes2eAEqsGv9dG4UpI6Ye1AEeZdrDi7aUCZw90fuf27tGJHzeASz7H+Wg
         8Oa7mJHqeyLTSDGHKE3jUE6dVtv9ehlRSSPR9jE2mvvSoqQdZWezOgBQCzX2GWrFveyk
         gVxir83T0dvSCtp8z+FfImifBgdgGj1ozJXe7cGXHeLwItpTPTpdcegCDDNm7qvfAVuq
         h5EgyAt6P5bxMavswbBFXR+HU1Z6iESC/80dA0DrGDciaaK7aavO00GTyx9AQpnztXpT
         mCwtfu1PEEgOVBUvf8fXsNdKLJ0ZVN30fVsFbJ1kriLSy+WlGNz3LhgyC7cf9PbaQ1fe
         Gevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CiBZdA/1aKSPOziW2ITItHHEr8zO+4iVmVXHQ4tT+nM=;
        fh=/vcNYrAJJb439dsZ7iBfi10x9/H/MJg6e/sjvEyepHc=;
        b=MO4iwOJ2mfwMh/rG1innHoXXMGeATppm1TeGs9qBG62QlPOvHJ6ekvV2ZG399I4zlo
         BrDxPYez8tfCzpTr3qjtbWV4uwz/lSby2A3LucLWHlOY+R9QkkgS2R8KC2y4yKPya6+D
         sncUTSCw/lXmu6HvWjliebBGIxKEewK9XIptH6Yv1p/AQXRxVJJC+iVDAuYWnoHWG9Aq
         JBEKzc6JPXlU5e8LdhgSgGE3uGYhYQcfYWtMPRcPScx/uRaIxuM4/JlAgKw9A0N9H8ez
         wWStIfe+mxtAXxxoFxklnNuEHDgh0QU3wvoLfX9NDpPoaGrehOtqadW3ozPK0DKeDo/A
         HXWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847774; x=1771452574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiBZdA/1aKSPOziW2ITItHHEr8zO+4iVmVXHQ4tT+nM=;
        b=ZWEwSoOhiSEet/SJW4nFoWq8dIuzcGYs3RmK9bHhHMgNalc4D3ooLKCYqudqNseQOR
         ggz3k6XPVLgzvhheQxRo1jh84wt4NdnfjbQw7UsyWnDYMEI4zepO/YDze0+0HlXLkCQI
         ZyMuCoGwqyqRkinZgaJJpzdafJffCsNICV6cn1QXOQH3YDp+5F2xi4OLkRzLO9NNYJvW
         Ak4btjLbbNEuKJbmAzwuyfaQOiBMa2OwfgUK/j1XE9u5DH6li9MuB2Zc/SKM+4W/uMsr
         TNO/a41T6XEEo6wo9S/LTlGaDZL3CrLlwf7Nmw+F/JhUKjXlfB2R0YwdyqyNwRFBz5TB
         irbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847774; x=1771452574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiBZdA/1aKSPOziW2ITItHHEr8zO+4iVmVXHQ4tT+nM=;
        b=RUHZPeFLSGs/2D8JZy4oQ0565xqtAfcXd9mmz1YsfTQdngsy/3D6G9MC+v+n+0iLco
         pm9MgHRjQUrUkMbaXsZ1i/t71B4UK3WRv/YrLtRak9XyX3hRXLK68UysRok4xIJiDVXT
         aQItSt+wch8vGLve+T3IWnT1RJcC/OaO0S5cPBXpQS33M+SRPjjoo1qKTFzi6OzYLZ34
         xDS18+L1HDDWxCw8vo3xo3cUAgM9WFQ1utNCgYHgP+d1slMGWT3r94FTDCqDI7jtFANk
         jRLR0wCgp4FFyK26vz2rusXI1KKoB2uodEW2KfAgg47W/EbQKSooGuArqOcnaA0O1TRO
         f4Ug==
X-Gm-Message-State: AOJu0YzKGNmyrI61x19u2P0FKiwfgkMSBFXQZJu533/+8cjTRNAJy+pm
	FFCtxgFVKFCS0Bqqe9TKUFN0mKDDrEmqk2dQUWRwUCrnyfYpSCJRa9rNwHn5pKv7IB/1hHQJDM0
	vfBsWeQDH/Abm/DGjJ8KOj0GIxxHrUnE=
X-Gm-Gg: AZuq6aJR6+prIdaAKQkCg6WqLLGVyAk1jpFFoK3+B1l9j67stXKjRDZM0tPn6Vxq4Vt
	35nWQkQcSpL30O+lgzUwl/PoYo6yO82ef4FOC7fF7NYBXz5CMLbbCJG6y4oTtHcpwW/Rl1/4JF2
	8llgjiHBCIYb8vazfxdljU0MGiaclHlD3wlZX89Ab9EtjhzJ0j2wlZUFSNYv17Pmut6ydNZISqo
	CGwjJdr07v9qDUEwAn2LF21eAiILu+A1nNJvG3pjcoLuHpnz+O6p6lW9DEoVaLZ/yJof12gx2Tn
	lv1uDukIY6qvhNcR2wgPZlSSLHtdDc4AcEdEDElaBwauJhJPnVifJePQkbq7ZOE2E42Re35Imey
	0Kp+X6A3BUZuLMc2Sq3BpHyRUqg==
X-Received: by 2002:a05:6000:4201:b0:436:42fb:153c with SMTP id
 ffacd0b85a97d-4378e73230cmr670883f8f.30.1770847773979; Wed, 11 Feb 2026
 14:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211181248.3040142-1-memxor@gmail.com> <20260211181248.3040142-6-memxor@gmail.com>
In-Reply-To: <20260211181248.3040142-6-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 14:09:23 -0800
X-Gm-Features: AZwV_QhnvtmcWjqyuHAZrWCbDEevY361b6qz_Q4qC6lrS6GOZDfSpLUxjcEeZRA
Message-ID: <CAADnVQLE-G00fRVAhAprg_NBSiRCv0Oyd9KVhNUw2XbsF+3JwQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 5/6] selftests/bpf: Generate various
 conctest permutations
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:13=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> +SEC("?syscall")
> +int conctest_timer_task_reinit(void *ctx)
> +{
> +       struct timer_elem *elem;
> +       int key =3D 0, ret;
> +
> +       elem =3D bpf_map_lookup_elem(&timer_map, &key);
> +       if (!elem)
> +               return 0;

here it definitely can be removed.
