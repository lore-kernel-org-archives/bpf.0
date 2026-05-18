Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A837A4BE
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107612; cv=pass; b=sOmDbzQ6CiWd5GFrY8yeancDHhiOiI4Ejl3R9lv9tRJn7dBtJ+T+cD7O+4E5bIAwh5toPQZuoRpmayvtwmugTAR1/321ifeCnPwXNN+dWKqYoWO/bvlEQ6AeIEOy5qJ5HgEh16vKDKQ5QSI6OYMZm7J0yXeRRqaA6jZqf2iFmQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107612; c=relaxed/simple;
	bh=Ifr64e2YJgWYjf1f0hHTBKtL2yHCYOwpPYPeoSBlCiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWdUrX6eJps6u9uy91PpmE5ME/0ukkVOIPfITT+aaCcq+93uuZ0faUjGc014KJdVkbS1pAKAkl+m4QTc8HbIvfAJ9nOYCVukK+JyFHRiaoDie/CPYTC/we0Ki+5I2FDJ+23J7IKLr60tLKC5K1jR/lqOvae/iNy+wG9flQgDnAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgR68Jz1; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgR68Jz1"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so2924695e87.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107609; cv=none;
        d=google.com; s=arc-20240605;
        b=Am1e9VLMkOgIA2PCMiszDz82Fwt753SEb37L/uQTCyhKjzaHq/b2+HSrDqsbuNGLwv
         ADlvwG6GRTPhTMr2dx/wGXoULIUC+AiUZyLflnMfNSIfWY5Qak9leYR407xrZ5kK5sI0
         Q27AT/UJBvRLzJM9dMBZ3wJzKXc/VK/YwUINUNCfmgRczwmyFQGT1AOg6JhfDhd6UgFq
         8IBIKTjLAjXt1DmEeZjrMgqbk6XXjFnkn+D2CHeTU2pPWQLKDDw7qtBtK5lC2/bcXDg7
         y5AfRRxXDekSWWmdnmxnq+7mfEdzH97ek750fT+C4eCoaWx0cj1t8ZcPOo+pgvU8foxl
         +fUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVEsgg5/subMf9Aiw+AjbNDpDrGt2FX5Fb3ebooqjrU=;
        fh=rUhrUqIQ8eimFtYJ8YGUnr/yyp18ZNMw/zrnihHUb5s=;
        b=O7i7dUE3VWYlO7YSJm+WyXVEQ+G96YzO2D77K599kqodvarFFFVUwtbzs9LzlXZt6o
         t50183mNUNm8QBtFzsJHZ/FDdUZhv4CKKuJ++XD+8uqIe2XFrpoAe45Bc0JWUl+QvwPS
         Go0nxe87J0JvaL/rHv39DNixh0508v6HS++l8DTWplwul+VjiplH+wXc7LsNuDjDNkTG
         pCHL0x9NB8H5Ec4QIwY91fgxxb+6dhK6odIGIyBWoPdEZ5IX0BY0C9Pn7eT2vJjGWfXp
         VTjv1UBs1OFZj0wm6woKURhqoYl9/jr0ON1NnykjpmSnLkfwy4eRwOLMpsRVVqXXokO4
         a91A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107609; x=1779712409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVEsgg5/subMf9Aiw+AjbNDpDrGt2FX5Fb3ebooqjrU=;
        b=fgR68Jz15H1MkHObu0Fxqj1UCzQ434bLKoNwnEdbiwlk7nGrMtSTBvV/8LZCi72aaU
         JCIPj3JuytdPrSM8mHYQFC0HPvc7f2tZJsbt7uw72alXeFhq/FDx+i3NXn6JxKvLodWB
         3EnfwNnssrHTCnd8QIJ8qKrSqT0C6k6zFj39l5FTwjnIQdfDw6hYzrS1lXv0bElN5Oro
         rpBVDuJ8F9Qyp/WDvsjRrGI7037vOSBxQHsLcTZJtaY9FzUZIj5/dKoPvpyjR+7cZUgW
         xec9x2CQ4hBIix+FcOLsHJJAJhUKFuJbzxVsLsYVN5qJfLb6vH8vMj0SUtTsN8R6whDO
         aFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107609; x=1779712409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVEsgg5/subMf9Aiw+AjbNDpDrGt2FX5Fb3ebooqjrU=;
        b=VA59xAGFtMxlorjlmJkqDTZ9ONjU0z2rOB/2kNLYaJxrmSwOOHfTeyGzCo0+br64FS
         jpbzGu+8grcCyyDokpEaXBKqUljGC7mpn/t8hZZDKNmamjBXBNJ7Z3O3+cFxDqWb49u7
         1iqBcApOcWrFyQLO/x+BlCAqIIGNL8+hKk7XD5wbWoAhGwO+co9gP5oO6GjzM8B7DN8v
         FFNA4uGEM+h+yvI/X2kq7s+tslxsi6QY+cUlj8Njr+c4qZr2Qj1f0NJLrwxTIPEf6Awx
         Z3xsgg7Fm9lm3eYgehJJntN9Bb3fcjgSbr+wewgGCpDsZF8/olcgb3vPKappaXhjPyPr
         HxTA==
X-Forwarded-Encrypted: i=1; AFNElJ9ch4Cfv+RPlZEjO3E6MtYDI+GfSdTXkARIGB386NO6Ys3+18mWAaX3Vyx8itGsads2+/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgDoT2Zn1O7nPB/cl62iYqU3GM85WyoWcFqDHwD8P2mL6Pc3f
	Ou9Vt6/cedQtgyu02br7XSOXNt4Jta4Zfz86EFBpI9DbMYO9bsuxLpDLpUdxMyoJbTzLCAI5YMV
	qdmM1TeFWhNFBenqhtXqNqjF4JjllJC8anZsUezx6+Q==
X-Gm-Gg: Acq92OHrt7xdjiX8843E6gHOq35+tgxj75ibnxL81kjY+uT8e/bbQKhFl9p797QkC2Q
	Y7eTQpFkfBj4tlWQJn5NbGaXLYt8ojZKtBYbXeE+z3KK4fGTRQ1VSqDgAttqJd077ZLm3fbko9U
	a02y67xUrqOdaiOj7/2dZMrPAqM/JXoTC7Njbr3DvS76XrvbEhogWbG/FXv/0HHelyY6glm/WjU
	A7FwQCmJAHqUsK1uZczLXsKrTs+uSiRu9Mqm0kGCP+CvDjJ0z+xapG5/p55wY5YvoQUGYliPMfX
	Z5oSbwGgCmnup5Ftac0tdRQXdmWMiwbmAspHIu9l
X-Received: by 2002:a05:6512:4025:b0:5aa:b6a:602c with SMTP id
 2adb3069b0e04-5aa0e0a96f5mr3681238e87.22.1779107608695; Mon, 18 May 2026
 05:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com> <928e935a-b7a2-4cab-bb1b-49c88f8dd612@kernel.org>
In-Reply-To: <928e935a-b7a2-4cab-bb1b-49c88f8dd612@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 20:32:51 +0800
X-Gm-Features: AVHnY4LIRdQpP64IYHtign6WaETaDhU84lBOzglbA1oWqz8gOuUpcEZ4Yhzxxkc
Message-ID: <CAL+tcoDgWZ_jib+0iZgVNLbHA_=e5=TjfOrJFfQSyuyd0ucf5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] bpf-timetamp: support rx side
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 7:46=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> On 18/05/2026 10.23, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
>
> You have a spelling mistake in the subject/title.
>
>   timetamp -> timestamp

Oh, right, sorry, this is not the first time I made this mistake...
missing 's'... :(

Thanks,
Jason
