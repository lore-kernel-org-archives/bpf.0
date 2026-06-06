Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D27171B1
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780716689; cv=none; b=bLySIICST+l3LnRYA9HzU9Qe5mx2pr/Gorcjugpb58LTbHS2I9OOkCw2ve//rXmHV71V/fX7vrfEpjkXfLVb8MJgUXmjnQn64ISFrND4qL8eYZhKMeRzS772F0ZcpVe7iHNwlE+FfRN2qiztLjW85+DcQhUiR4fZLNENrH55bZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780716689; c=relaxed/simple;
	bh=utsLNBdN59I7tdcd2q47V5f6UZAu0dHB4Y7+26Vze2o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jsG1ZeKVrj/DBxBwPiukfi+UTZrS6J4+uHGA7GSBK3hgHyrfgIv6UwWwaaGn3J96BiJb+nJqLYWPVwiJeR/MvbAv9Cblr2BVDcapG2zz1W5a2GbcEVwFyZ3i3X+UpIC0ONkb6leJUUEQXU4HunVnIeqKWdoJmL5qzJ3/IG4oq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKGFM/Ij; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKGFM/Ij"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e16f05fd79so28071247b3.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 20:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780716687; x=1781321487; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0jsNwkrkbumwt2Rg15XnekTt8Tzr7ZCncQ3gCE1aBE=;
        b=tKGFM/IjGXvDfv3opOwX/uz6gSCvvXSDsJvDDKnOZ/QBtOqwVNdbj1jlp63Cm+iFpQ
         fdY+6XnIbTlg4dfmNcf6ZM/3cQQ2rfcr2WOT8ToZ83K32pA76vg/jzbKgSeR6bf13MOt
         6EVSFC5BbYAAnqWQLQy57N0GNfqSWSISLVY3G5TcTievBnJKi4JKctQscoeTjjEBcLPG
         Odi/KTEwIy7VJH/hHFNFPxab6QSmMh1uETlhlvSQvtRRUHAbEg4ivPDnA/yrB5usE9gm
         g3DWf0IFmAJSJJpLi/WY7xjQNw2iQlemdRADExS4AxtqnVW18dYW8IrGcSA1BZPxDGa7
         TbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780716687; x=1781321487;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0jsNwkrkbumwt2Rg15XnekTt8Tzr7ZCncQ3gCE1aBE=;
        b=VnnIKfQNPuhfzz7Yok+zKXdAiQAnYA2esdp8VJd31v9Bba1JaXrKmR4P9bY5F/DMQk
         eWtBYmDvmf2spp0UHD0SOiqvbAQDTMafwgxAwgPMveIc47AdCupuuXG0MtDZWxBtdMcy
         gz6XHIfMZnat1HpsELQcjKIwdqDWguSUgiIqBxXSP44MqEJJSq4CZpaG7ERZHW35AMEC
         7ubxA3x/cFSpVOfruJDSpzJkmx58yPYRy02M4sHRlNNvw1W8Qgu2aMMZy+ImRmhWO5HX
         xrbfGi+UzAPjApPb7tTyBIsdCXA/h8mxnudupB1FOAiZkeWuqqe1J8X644YdYbdxFPYw
         ifWw==
X-Forwarded-Encrypted: i=1; AFNElJ/qyKeDBFjqYKi66FhAzEBBFEOTZZIhkUUqPwVVVeyPXz/TV+W+ZBVbPBr5bL34d9DelLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfW6nWOvA8a8pzfQSr4u9HGuCaktDoU390MHz58MfVRhmkOa+
	Xn0o3ZqWE3w/1KGEvZaAp7xBxiAj1E4oH3uBYJRa4+B6O7rJg+tHyNnj
X-Gm-Gg: Acq92OEJyZk1yuKqozVCJbI6Kg3KQA1q0yhJJmUHaq3sRjX9u/0AWQdsw5tcV7qyn2d
	BkehOTCwqozM8A8pLsFSAyqynr6FzpJ2v5Df4wwLMCKZfNg/2Z5n0uIYn8GHJpPjXyKPnonw8TP
	M0z4Pz+Qs6k9ylIbUxzbCI2Ic/rhj/IRX+5KrijW81B/oBdFyscek/RAJe74jZkM5BPUUNt2uKq
	KCdwZPm78YYSndU+pFh9lM70TECVm7JsFneSuuwryPA815Wl9YXSoxAfcQdJx4Vvu5P46Bx2Gih
	Mo5jcSqRabmHei7xJyVzEXI4lqFdm85VBslPL7p3ZE3RKJ30eQ8BRgPPenrhZwipSfk7EKp4M8r
	OaftwOtQFLmjOMAcz/FqE97wKi38A8FMHH/3WeBIyMa90VvbrBcralhQKmVCR95zEJJWumBQvzs
	09WPLyWTlxzJIZXR84J9Tu50RVSXYWI6pbG7jI2o89S2unm5bYWhb3goZ/OJK9pKlxhQAUua/vz
	vbUXFSD2efZUsuz7gkUA87yYGC4fQJsCrNUgFVFIFfoVQaS03lTKw6QA94sjQ==
X-Received: by 2002:a05:690c:4d04:b0:7dc:c477:9e98 with SMTP id 00721157ae682-7ed108cae03mr64742647b3.31.1780716687092;
        Fri, 05 Jun 2026 20:31:27 -0700 (PDT)
Received: from localhost ([2601:7c0:c37e:2360:d412:6d5d:4bc3:48b2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea819esm58962707b3.10.2026.06.05.20.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 20:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 22:31:15 -0500
Message-Id: <DJ1NDNGUKCZR.3CRKEWPZ3OOMN@gmail.com>
Cc: <john.fastabend@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <martin.lau@kernel.org>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH] bpf: Fix signedness bug
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: <bot+bpf-ci@kernel.org>, <ethantidmore06@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ameryhung@gmail.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260606024540.47362-1-ethantidmore06@gmail.com>
 <86b976f32a179141dbeb3eed5fa106f18f2e46b5c6849ca2c800484847d1deb7@mail.kernel.org>
In-Reply-To: <86b976f32a179141dbeb3eed5fa106f18f2e46b5c6849ca2c800484847d1deb7@mail.kernel.org>

On Fri Jun 5, 2026 at 10:25 PM CDT, bot+bpf-ci wrote:
>> commit cc27f12c12ff54b8eace339c3e130317bf205277
>> Author:     Ethan Tidmore <ethantidmore06@gmail.com>
>>
>>     bpf: Fix signedness bug
>>
>>     The function acquire_reference() returns negative error codes and 'i=
d'
>>     is an unsigned integer, so the check (id < 0) is always impossible.
>
> Is this commit message accurate? Looking at check_kfunc_call() in
> kernel/bpf/verifier.c, the variable 'id' is declared as a signed int:
>
>     const struct btf_param *args;
>     u32 i, nargs, ptr_type_id;
>     struct btf *desc_btf;
>     int id;

No, 'id' is assigned as a u32:

	u32 i, nargs, ptr_type_id, id;

--
Thanks,
ET
https://github.com/sponsors/ethantidmore
