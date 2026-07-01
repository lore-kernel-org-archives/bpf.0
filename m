Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518D349CC2
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938800; cv=pass; b=g/njH7uNeDUHx4Wtamdk0qeziIF8W1tQdR6Uwvi/KC2E6O2pfWUSATeCEjKulDpfaE9/DrKMG4/s68eoJVhvoRTGz/8iDewSew8HaoAzMm5+jy8uSqI4W3LwfWUOgADmaSdLxVIr1fv2R6VZfg2V+XBRsNWOJ8o9TD6PV50cyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938800; c=relaxed/simple;
	bh=RojmrvKSHS5LSmtFILF0XQmAa/5JCgo7nPteL3bNh9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzu/ZhFizvq2uTGQD2N2yYaCbcsNJyqz/Lvva+J2iJ1HNxQIrEcwsXiQrG1LLEoAwGIkVZnJlQyowVazMgfCH3YY2nnfQJ0PzxIzuNZTMRU+PqWnIN9Tnd6cyEpCfisOXY4M3mkzVk9eEnNOej3P6wPiYsK1LbGtQt9ckI5vKMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n22tdaLG; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n22tdaLG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c82538b6c0so10702175ad.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 13:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782938798; cv=none;
        d=google.com; s=arc-20260327;
        b=kNkRZB/wItTq3RFjCWt5s/EAVSeL3cLRIVFum3ShJaQAjt966RpwJOkgx+FnGruf4B
         pakU8uM9Gzg+XYi1yQgWpkDXXkU+6wt2hsur9da2Co9n3IU15sexsF1XK2q2fWX9cfMh
         tx/Apf65oibcfDnQB1vLByoCjwhCvQaeLhjlCvhvAWFHdHa0+imVzS4VpA6QUI+4Zi6l
         BDq/bm5KWdIs2KKSR2N0UWcZx+Hpgy3YmG1aouVTvFgdn74/+HEY66KRmbh28MHHQdOB
         niz27/T5A/aWmy5eFr8p33LuU7lpgdf4PtMxSkMOvgxdFQGRZL4VpgGaSFcT6p6sVGAm
         eB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yjZxD1cg1vS2nweGbuL1y88ux4bBRWVLVkOZtd7axm0=;
        fh=WXXCI0Hym2iMsbmgZJmVLuIzDUn5O8nXVDG4i0Cbyyo=;
        b=YlJLvl39gk4/OJ/Qv7KCVgVJigg87xhuuBU8W7ypWKfG07JJT5Nuw+cpdxpFUYSCA9
         i1m3tDGAhxUy25h0RNRtoYtnnIuCkzdcW9TGklg/VK6FZkaEpugW4KqBiYxHZJutKRew
         NKwJU0XJTA9h8oVu1a5MDfLz/X8/yX85uw/k9hu6J2fiGsZRtIJEWGdvHSBpPOdmnATW
         Hjd1YwfVOLDbbUAUOkZhz9UQoYAIGdhtmw5KBOhRBeE09RoeDV3Jpj2MNkjXnFUqOnN4
         tlKoZgEOSCMRaFke5neTumdXZD1xEvdA/Rfdw5N7La+16b3/pRUCHi4q8wrqU1KEJEuW
         8EBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782938798; x=1783543598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjZxD1cg1vS2nweGbuL1y88ux4bBRWVLVkOZtd7axm0=;
        b=n22tdaLGEdT8Udmh9bzmeau9F9cPB4YL4x/3TwFelAAWtPbDx6v0gWXcoQWmEz/DyB
         MpRKMbqXWVTrNaWNuABsrhZxb097xVqjSMQYoWwJ4ap28iNFzU7b6AtVDJqByFzWRhjJ
         Io1TxMad138E9WXN0dRc16jONOdzlglDnUC41b/ndLbA8L48CzBjeqmhO44mKb8IpO5g
         vjVEqteeRQL8t8Ki5TIk9epFWR1Vg53A4rOY1VxSUtk7lSNgZPSVp1GklBCbaxtzmEom
         oohm+o3gVX/CeoC4sgdIcJq9NdhxT3AusSieKzz1x16QYhI8nlsJB8mx++2HpHKpQncY
         EENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938798; x=1783543598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjZxD1cg1vS2nweGbuL1y88ux4bBRWVLVkOZtd7axm0=;
        b=bDI3ZhansLk/fQq8ECdZURpG6/2vESNgg6SWcyoOwBQtBMfcaw0ssCeSW6SHnRIWeT
         rgwEmAovT7s5hToM2bngzncfitQyKgxyThldWMN1ekn1zlKIIAPZ0l+9CaFsJK4TyR3D
         gYdXQg6xBVv7eTO1zWtaTaCWr8zbACAwPTicOGFkgnatr3wvp+GsMTqG7agO6AYrSDQq
         ZhpvAKU3umMFC0dhbTVCI94RlSDwn82O/j9JzJsfYfRSvZRJAt9JNU88pSzZxr+xPCVv
         GK6M117qLTW0DFUPNnRDYcEZ/VgCaOpwO2pe+ConEpU7LKEYQfl/EsaA74WmH16zxlzt
         OMoA==
X-Forwarded-Encrypted: i=1; AHgh+RrToa5As7Bo7TwGFTgs+VejbCKQ+stPsUISRYvXqhNA3730US0DD0V7oC3gbP5EdNVZFIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKyRHTC60HV/mFFskFXQbFflZZ8cpa+JqhjkW1OhCH1YHx0Cb
	hLc/3Ga6a1SMsH1g544WB6i/6YVJE3O/BGzn8XS8Eqd+8zii+MiX2tpIB704Wu8MkyMSJfEO+3r
	dbiUwzXQHNkKexAvOX9FYAvKBoVtKq6qgEw==
X-Gm-Gg: AfdE7ckKAEjydew5EH6mIth5DV2wmv8i4/RSaFfa20Ms07nJRsAAUepV8x+4L0DrIbX
	Xluy7/ijnzY7/tQoEJik+M2/gdJ3+0WsFkPM6+XXtsiyfn/KQvlIH1L6xca6QA8dSkWQzEpevif
	JQpy4lR24MqSEQ54a3x1Oxatzt+f8OwDXBuP8S8nRMUykWC8KmM7rThKrcrUdzQeigiPn7hU7mO
	SdeZeIGoS7TUhvGisikAj5cTqm+Hx1rt3RdjZ/fZGCtqZx9nZFBwamDe85Uhbgbc8eEGtmWIv6K
	EaW1wPpti1Hu8io4q1jpYZMZakJny61+UL1hAy4zdOhVujxKGxClNA==
X-Received: by 2002:a17:902:d4ce:b0:2ca:1bbe:c3d0 with SMTP id
 d9443c01a7336-2ca91227efcmr21654735ad.43.1782938798277; Wed, 01 Jul 2026
 13:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604031033.806727-1-chenyuan_fl@163.com> <20260610145059.113412-1-chenyuan_fl@163.com>
 <20260610145059.113412-3-chenyuan_fl@163.com>
In-Reply-To: <20260610145059.113412-3-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 13:46:25 -0700
X-Gm-Features: AVVi8Cc048TcgqKW0BWdZFzEbi25RateWHAZYZuQD3fYS1IrrzOUzGBWw3yq46M
Message-ID: <CAEf4BzZ849OG1XP6ZO351or3wqUViKtWHAii9vFyEZhu=4QS8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] libbpf: fetch probeable prog type from
 token for feature probes
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	chenyuan@kylinos.cn, daniel@iogearbox.net, eddyz87@gmail.com, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 7:51=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> Feature probes (FEAT_GLOBAL_DATA, FEAT_PROG_NAME, etc.) hardcode
> SOCKET_FILTER or TRACEPOINT as the program type for their test
> loads.  When a BPF token restricts program types, these loads
> fail and the features are incorrectly reported as missing.
>
> Fetch the first probeable program type from the token's allowed_progs
> mask.  A new helper, token_probeable_prog_type(), queries the token
> and returns the first match from an 18-type list of program types
> known to accept trivial "return 0" programs without specific
> expected_attach_type.  Types requiring expected_attach_type
> (CGROUP_SOCK, CGROUP_SOCK_ADDR, LWT_*, NETFILTER, etc.) are
> intentionally excluded.  Without a token, defaults to SOCKET_FILTER.
>
> When the token has no probeable type (e.g. only STRUCT_OPS),
> conservatively assume the feature is supported: token creation
> proves the BPF subsystem works, and real issues will be caught
> during actual program/map loading.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/lib/bpf/features.c | 97 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 89 insertions(+), 8 deletions(-)
>

This seems a bit too extreme. I've applied the first patch as it's
reasonable and small. For this one, we'll need to find a better
solution.

Can you explain the problems you are running into in practice with tokens?

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..f008ee50e246 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -19,6 +19,57 @@ int probe_fd(int fd)
>         return fd >=3D 0;
>  }

[...]
