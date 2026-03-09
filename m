Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DE38F255
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074654; cv=none; b=nCFL5NfSMGsjtzIf6x0MUdlSsjLgfmJayftwrBDVk9xb63oLAazGQ6/JaQaThmxR2cQVPqcjWvzWGHWe3Ir1rz941hOtwqaQTT6VOdE8AuJRZvsndwNWuVyW2Vp//gFh9+ZBicKF0y6r/Cl31bTSg9fMLNJZcfiM6in98J0ugr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074654; c=relaxed/simple;
	bh=jdOQB0L4Fflv1gMm7YHka2SOqeBet5RHR7I2KGVkz4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=T+YMnZKfGB8AhtD85erV7gNK7ebP3/SuBoF8Nc3iBQTlQ+AxF+DKnfhC9IUo3do/IslNAN675k7YHir3W5ZD+vQ2CVQSK23SMfjS8YTZzF7wT7vckoSdyNdyv0XiJsWfkMapo49ZtW9Cu+n27NtbY0NkCsXl9j/i7ADJy1AZiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=fKbV43hG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="fKbV43hG"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509061dab77so22807431cf.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773074652; x=1773679452; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkcB94mfZF3arnvqPMVSEZqSUd0e6HEVcHvUbaufTrY=;
        b=fKbV43hGfRW1215Ao6bYUwp6WkxNQ4ltd6+qF5K36GkaiFjVHMKpFH1c8Ps9nFPrFh
         dAQy9NBSwaLdVWqHgy05WzX8fvXxVkAbe8kkTC3cV7fgm0R/fmyqF+S1G2+r7iUTcGs1
         ujV0RgQx6CubDGV6Yw4/EiVk+Qdls80FJqY5VvDIOZvuyRTQbz7nLjJH9WiaU6L3fmDW
         I86AMXUszaXUDLrqfzy3Ln6QIBCL7exww0yGNyMCnTCmb8g4Z+TD2ZauhFW20iun0or3
         WG1WBFJyPvvYl5RZtVcRKhfc3w8TOw4AP8viesD02YmOtvlZfH+yeKMm5d+DQ8l5o1Fd
         AUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074652; x=1773679452;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkcB94mfZF3arnvqPMVSEZqSUd0e6HEVcHvUbaufTrY=;
        b=Xr2m3wWViIxQN775xnvyOY0XXGm5BvT3THv2F9yBiwtBfq9/fnZduYlvZe8oGc5PJy
         /1Kxzto37PPLuQlwxlmSHNix5qehZslTmwmdZ9JM77PpBilLkPkdrXbZkAM2am/fyNqB
         nM/jOq/OOHHFButjGUfpWDInZDwgxvX32cx8shU3imBB3AJhOMr6b9WBkllgtie3nxJM
         BqL3fP25SuRaBYD68v2dlUFaWGji/7TKNv7QlREHaBTPteSFBtajAuPIWBs2a7PAvCQg
         HMFMDUGWw6otOXMwI3hj0gXxBMm5CJr8tHWl2gHsJ6jK/pjWIZCzN1dxU8fXaMQpozZI
         dRdg==
X-Forwarded-Encrypted: i=1; AJvYcCUA0l9q1n8VZIAZjxP4qm9c6K1IMuGEK/ANt7GrKJQeXbuSR688LGxCOEZu+Jtb6t9OBoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBd4w9gSHspP4PWNa09dKUpqerR0UJsknsgYfg5hWStFe74E7E
	nWtOHUteHedGaTpPHdY7yFsXjxBr4UzJlE2SPIcXgHx2CsvGD6vsUz/xqscK8chHwmw=
X-Gm-Gg: ATEYQzxzYpaZEXLJ/H1cSRaco8v30rcHaTqkD3Bkh66TA3a7foCpGcp/houmE5wHUj/
	LrqzD2fEU488MFmJvM02Mj+Ud0XxQoASYMw6QsRjosL0g1Sf6AdCWDDaQpqUXyba3sdfA/bPUWX
	csbIHa+kyuZXv7/MDXWrX9EC7oIombINvyS2yr20vPYmBkq81lMEmhioWB2vPnYrK5ChN/s+4Uy
	L3Lo6akLyL8Rpg4IT6Bs7wsKLPEyjmzEamvn6kFSlbozgZReWoJRn4n8UYmS+YpVxTRPNStARUn
	t+e3O1MgfTaot6kH4MMmvPWubjlHe7yHAQUGnWbACw1X9pZ8AZAuF4jq5fH6mRmlzoZD+NDmT5V
	8JtKphBapRetOfY30ifMuaI1+5hcLtup2bh5YUj8knA8Fz6x/dqYPpIWr5l3unaSREPTkEPorz+
	7m0m/lCqAWkbLSeamWlSUwe8A=
X-Received: by 2002:ac8:5a91:0:b0:4ee:483:311f with SMTP id d75a77b69052e-508f49566camr153324811cf.54.1773074652455;
        Mon, 09 Mar 2026 09:44:12 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66da77csm65808051cf.30.2026.03.09.09.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 12:44:10 -0400
Message-Id: <DGYEI9OL9F85.2CFAJFEYT0VUS@etsalapatis.com>
Subject: Re: [PATCH bpf v3 3/3] Revert "selftests/bpf: Update reg_bound
 range refinement logic"
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <shung-hsi.yu@suse.com>,
 <paul.chaignon@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
 <20260306-bpf-32-bit-range-overflow-v3-3-f7f67e060a6b@gmail.com>
In-Reply-To: <20260306-bpf-32-bit-range-overflow-v3-3-f7f67e060a6b@gmail.com>

On Fri Mar 6, 2026 at 7:54 PM EST, Eduard Zingerman wrote:
> This reverts commit da653de268d32a80e135c9eb960a8147c186f1bc.
> Removed logic is now covered by range_refine_in_halves()
> which handles both 32-bit and 64-bit refinements.
>
> Suggested-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 04938d0d431b38e086b50fe28b99e4ad2682742e..cb8dd2f63296b826491c8a010=
f4ece4aa20c0560 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -519,20 +519,6 @@ static struct range range_refine(enum num_t x_t, str=
uct range x, enum num_t y_t,
>  		return range_intersection(x_t, x, x_swap);
>  	}
> =20
> -	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t !=3D y_t) {
> -		if (x_t =3D=3D S64 && x.a > x.b) {
> -			if (x.b < y.a && x.a <=3D y.b)
> -				return range(x_t, x.a, y.b);
> -			if (x.a > y.b && x.b >=3D y.a)
> -				return range(x_t, y.a, x.b);
> -		} else if (x_t =3D=3D U64 && y.a > y.b) {
> -			if (y.b < x.a && y.a <=3D x.b)
> -				return range(x_t, y.a, x.b);
> -			if (y.a > x.b && y.b >=3D x.a)
> -				return range(x_t, x.a, y.b);
> -		}
> -	}
> -
>  	/* otherwise, plain range cast and intersection works */
>  	return range_intersection(x_t, x, y_cast);
>  }

