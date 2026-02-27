Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9673A7F7C
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225029; cv=pass; b=eplAY6bhFJ74Ge7JYu5jqEkY5Qlk1nQZU0ANQ+MpuxC1dsc4IJW9v9FQOvYGLkSWUeZDaEDKOXUOXzZ14TbWprYc2QfPWSNazm4EDzazo4DiJq2DCWWcXlS3wVJvNLD/bMcvfgpmlOircw1AQA7ozJJiL5lCeHNIkqrWfW+ondQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225029; c=relaxed/simple;
	bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4o6UGA8Dr4LegHkz5piSEYMhY/v2s5T/CEwmdNWZ8aIZu47M5WWo1i1ecyBwpsUy+O0eO6rYdPqk+CdP/exhDagcWJrgVfVJJ1chTjL5CRv5pfRgwe89XXe6XX0hUgA/E8L1saPWiQDyJyyMqQJSgRxVgZu6XasMCTWTr6peOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpfqDS+Z; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpfqDS+Z"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43988056dc3so2453926f8f.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 12:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772225026; cv=none;
        d=google.com; s=arc-20240605;
        b=L6nwO5l+TFHgBfixWXjPLq3/XgiRP2sJnXSeJBTxEaN16oBXfps8Wz8bv/jrmBCc7t
         Hc58jryJxzTd99Xd3ob5Uk0HVba+0Fj7+p7KELoXvVpNOKSieRIaq7LOVrDe9OeDfRlT
         i+vou926IYoumX6pzDEKAjOU9DTbCga2+JySJRglIFzQZoC52n4hnChTaekG9UO8MdHN
         qlKFiM+M7gc5XuUoaxsijnZHONKwoO6mBwJBdssph04UFJRKfXI+eLs30iDghU4fDRiu
         F5pKlMGfHMlbtQ9M719XSFYIxUayWvt9BS7vZnzXAq5NqJq2HGXj2hZirGYxsuwSoVOX
         m+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
        fh=080qAfLdhWk0HgeUonk9HsSHR21kPUNhUPw00BXVzJE=;
        b=JFrKaaqFZJzqgfwU6ZoHAS0kYzl/7K5yqhd5UMLdWB/XGEZrzHxDoW71br+lWIVUQT
         DkQ0wJ904IqbdqIj/MJOjkBJe67t4OxFehGH8cFBxAaHRIxRXPerNq2NXAWAWUCbWCxs
         Qo/WfQu2rGpGAZQ7iobqmYe8swEQxAYUjb/2OqA868i29rg+oduaaQsKCoXfJIWXfDPd
         RN1Po+wcCLXeXJvNotSxql2G/cf6/GHvm55BbENml994QD6tRIqrFVMs0TGJnnrOpvS0
         OWx9QwALHGtUvOspIRw420jIiP2MLB7tDxbErzkxI/QHlYr4wHHZZJhIlFZzeZ3HeZ6f
         16YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225026; x=1772829826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
        b=OpfqDS+Z+LOKbhP1i6kzX1mAauPKLAhx7OEBne/UPFErvtOIcnI6GOMykfyee2w2GI
         JifRRMdc1kMNGPVzXN11mgNljSeDOKxG+LbFDT72QMBgZX+hYUn/no4KeSSlMnmgE1Ua
         G7jF+dicgqefIRzOUbFiPtBV7O/fN5/l9aNB7RLNEReUpJfwlZQheG3y2YK9mxsgC+9/
         PefKocH91SIm7l/l1RLj5A6FLFu61zjGdzadBoA214CmhaakECmywgNkFuLiCUI/sHxh
         Xg3MJ9r+rwu2B3H8qBfwNX21tgDGF9oUsswLUYanUxLAXytohwAF+icUiwBglb8SDYmT
         k1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225026; x=1772829826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
        b=fjTIJjvEsc9TnAinugjW6T9isynIndh3x9bLObZmvVa48V5XYpIXS9uSVxQa0Q7Wm3
         hQDY63/s9gb6NGRerzJMUe6UPCSI6qHrfV/mNxghw8/WUa7qlQ2lNmod0/1oUVlgqh4T
         RcVVqH4SZQdn1CIo7NpHiYH1FSf/Rk1Pug/jwqgWD0dM99IH0aXQ7xxJFeFTqmCUpasg
         JOKmIPSVO+Of7aodZDyRkXHHw0O9Siz2w558zGfg3qTNMUX7AcUbhHfAYp2+koAW6V4n
         1Jzw2JXHpLnPj5ByaCGmrL9v+k+nNC91VewtuNLTCsW05r1Q+f42ufF1Pr5LMLm6Ze9T
         3fiQ==
X-Gm-Message-State: AOJu0Yyukhpx21GqBqrPkmr+8zvWFmA8iFxrh5M8ro5K24vqFUsZv0R/
	QUWOKElIJRI3qNr7M0S6uD3ntyTgLwoRxFrMbp4rX38nKPX5CliIEDlh9XzGjbhxpoFyPKPyF0X
	QloK3pSCxaavnhJkf22UJ+yswFiEvC0o=
X-Gm-Gg: ATEYQzyXwOxHMQXFohh8ZWcdNELNsrgXOTSunpVnHt/9LVDf1fLEUk+kKZ9dZ/ZTWyz
	vpJhdt+cOgxCgHtorh0Sk5API1FBpkBThaXfK1sdFayANY9SviNPPy1/h9RZjxb/1nrfF0AJQwq
	F5L2EVN+CjnmXs54gSe6pM5BqtuVtaa2yxEkIm4Te8bbKkjh6piJewbGGVerpos87AB5ErErPjW
	8H/HsUPQBv2tjOlOKhAeMZOZEkvynKbmqewwcp1rdC40mV9HgDtrhB88hRSDZ/XqZPXGCXajUjS
	2hoQDjgeF1fgvWXfkqHjyarywi9V8NTjYU9iTWNPajtM2M2qJoLEDA3FfXRar/0+HbcsaWuahHp
	r3G84+388TmYloFv4sGhIaCfn0w==
X-Received: by 2002:a05:6000:18a8:b0:439:8bff:3639 with SMTP id
 ffacd0b85a97d-4399de3e54bmr7056308f8f.29.1772225025953; Fri, 27 Feb 2026
 12:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 12:43:33 -0800
X-Gm-Features: AaiRm51HtdBeaDeEwCSOw6inKTNkGNksTd8tcKmSDenNN5Aj-L_HdGa65_WcJG0
Message-ID: <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 0/3] Optimize kprobe.session attachment
 for exact function names
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf <bpf@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:41=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
>
> Changes since v2 [2]:
> - Use if/else-if instead of goto (Jiri Olsa)
> - Use syms =3D &pattern directly (Jiri Olsa)
> - Drop unneeded pattern =3D NULL (Jiri Olsa)
> - Revert cosmetic rename in attach_kprobe_session (Jiri Olsa)
> - Remove "module symbols" from ftrace comment (CI bot)

RFC series are ignored by CI.
If you want things to land, drop RFC.
