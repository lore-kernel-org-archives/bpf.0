Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D17262E
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773028230; cv=pass; b=qVXmxFzPf8XJm9sowEHmyBUpN+sjpSeqiZqmkDGDM5azabFVlg+Fv5dL+0wvQ7r9YNdqK4mggHySjBwKwMrNwN9fiIw2wewVecWPl/4DBV6z4FalJwwhamduFDBxEEwRKQd+/Ro3nU+v7FbNr3b+uNWELqvCzy+5JcIoDRwYfIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773028230; c=relaxed/simple;
	bh=RdEIT9ybKdemBVxAis1wIx3aLUIDAFAUwrYBUv8C/Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe9cCfemsaHlzn9PM6rf84y9Ngm3535hw9wy9FpGVL2CJKROghcapaLalyiGw+i6ZrGS2Bx6sS+2J8ex4Ilhib4vV0tOjgvZ3zVFQt90lWRJMWfoqWO+NA1PwrPjpmCvy+T3OPbLVGbljtAs6fjxpaeE3XGwIBlM6sl7BVx+cww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA8WbDW9; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA8WbDW9"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79902e1fb71so173937b3.3
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 20:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773028228; cv=none;
        d=google.com; s=arc-20240605;
        b=OPFJdP6bSWjLdRQuikGv/X6b5eruQlr96vgPdA7x9iO3G1CU6blnQW/NublE3lymoq
         P954gJ0DocuWsu8f5oY7pHfp4qYltWI/p7pSOBY0hYkyoAJJ0LtKr3MXH9SylOwQSL8l
         M3qlHAKQ3+gx3z68lRsF1dS4Id45KWsw7jj4LRUEQAowVUJqIYGwDYIug/Jy/KGsDY4F
         Wl2TzU4xV1mlV1sF0sxOEdJrD2ueE1GPJUorlBGBM7APo5up8nIBwlXwo4+BYJFJmZlG
         06Z/PHQo942af6hG7oOXs5LOkZDOqYA8vws0eCnnX7/94uzNURf7n7m5MLaMGsFyA9UP
         itmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RdEIT9ybKdemBVxAis1wIx3aLUIDAFAUwrYBUv8C/Y0=;
        fh=CbfzIsWdXmtRa1jI7EGmFnzshm3HA1tEaoFIpXVq2CQ=;
        b=d54eCmmlY5u+us5J7ul8xe0YV/acxYovm49+WoCvCf1yZG2eR5SZTv0NebB5z4oBDS
         zT/DT6VqMtUTagDNz5XuGPIRzBn+jpC6xUE4lfpYZU5KrSxVf7iKdcj6Gmm2loDNaLu3
         xTov2JPo9huq/M3YsdNqtbgaD68m52t706WWeQMMOBA+nwbU5/gBoVRWXOMxE8W7c0xg
         NyZAT8V+8+PL3yAfHSWP6Bl3ctdKoWTXyi6u4Ckfc28IKSCsY8R7xOo5S1TBsbidMCAs
         VVtwEqgJdqM/wVczbgz2rsj6ErCNDVk9ftGbqlDuWxrqM++JbLJ7Sw8ATdWMV4i8cgUJ
         1X8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773028228; x=1773633028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdEIT9ybKdemBVxAis1wIx3aLUIDAFAUwrYBUv8C/Y0=;
        b=BA8WbDW9yAFx8pPXEzjFFIQz9yPXKktwBcjHToCqXlMkSyB4VjsLFbJYo5HB/ViHqO
         tn1YYnqMNQyIbDXZA3VfaxdQpxmOrwLL6wEcQGtAXLBGZRz74+wAcRPgwDtnAQ+E/zBg
         tbsob4jBG1JjUaIkY+Nd+2NOiLUQ4c6nOv/ZBQdlN3tWMuL3sERNKZlNpL0F5zBG0MgF
         YaTivA4ruulby3FGDw+dLYBupCVrGkyljcZIwmrAG5IIzNJ4mo+AB8/BLTl6etrsNDar
         9gMKIHatpnuRSjC8sFAtdoaMYbWy6XuqcNUylw+VpfsNxeBJ8FKQIn6odFKrY8HwJkw2
         lUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773028228; x=1773633028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RdEIT9ybKdemBVxAis1wIx3aLUIDAFAUwrYBUv8C/Y0=;
        b=Xg9QgN46lYPZrdMnnBC1yvpFWfXJBclnLyLap3OrcuUafChs+/uPLm54B0OPb4vOZA
         JLFfTFWeKQWUUTnenciz1GACwBuG6n8HdW8DwweZfahQUf/O5+ERGCChCKzrhUHymRaS
         Ipn9sEKoT1n9bAg9Ay0qzisU8o/wbR+4sArweiqULCvlTfkYaJYB5Ey7o1yFn/UEqXYz
         zGWa9GIGrmEFw3SyDa0dT2DJxWT0nHIJJezIH0enFTAbHN/atd0Cmgje8k7wjjfQXLZQ
         dWQ3dbwD9ea5BUzDoOJZt91yDilVA7TzNlWHB3XklgT6gP82Pcqk43dKA6NotY1fNxCI
         leDQ==
X-Gm-Message-State: AOJu0YzDsxZ9i/WQyfrwUesYkTNT98xbRmvyjXf5VRGBZ1Ubffr3TJWl
	q952Y5AI3R4m8wdr/kcr+0a985ha3FVvlQhJHAG3t1TyxkKlJ9zBjfy4xJCUP9rZszapw98H4cv
	5frTHcoFz/fZd/KCmJKr4d850uxBCCeA=
X-Gm-Gg: ATEYQzwx39Oaxxplg6ib1yedLrPfQ2mzNf2X322BKnWPazifokwqxItozKuXymq9WI1
	dQrJSB9r8HIEuPH2UbrDbgF2vqWyS5YrYsIHn2b5QgdibUYWX3DYGC09Jia2/Exs85y6sqF7YAe
	a7TJygj9XX1dRYt5LR5MLu40ycByGKafrn4riLDvAKUDoMg8oOFBUKupvPrmsafvsFyuega1+jt
	MdepqQg0MplnVjCOa80IyBhEefyR6SjojSaIhBtqdM8yeLvaTBNeXN5hrbwbJqmZHsEci7C9lri
	4Pd3C+nx+ozKc6I1DK6tp5LUQp3ywg==
X-Received: by 2002:a05:690c:c52c:b0:798:65ed:bb9b with SMTP id
 00721157ae682-798dd688c7fmr89351937b3.27.1773028228644; Sun, 08 Mar 2026
 20:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305030258.5273-1-sun.jian.kdev@gmail.com> <aalGh2sjKl_mZp7G@krava>
In-Reply-To: <aalGh2sjKl_mZp7G@krava>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 9 Mar 2026 11:50:17 +0800
X-Gm-Features: AaiRm51uUEhkJcmn4QO3MwOWN1G6F5PFKmsYAMlcoRfnq31RLjwF3XvQDes7nMQ
Message-ID: <CABFUUZHXROhFTgVtK9CS_PERkCEJrJ6d3wAfHP9GLa7o+mVLAg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: livepatch_trampoline: skip
 when prerequisites are missing
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 5:02=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> load_livepatch returns -ENOENT if we fail to open the file, we could
> check for it instead of putting together the path again
>
Hi Jiri,
Thanks for the suggestion. v3 sent:
https://lore.kernel.org/bpf/20260309033712.728133-1-sun.jian.kdev@gmail.com=
/

Regards,
Sun Jian
