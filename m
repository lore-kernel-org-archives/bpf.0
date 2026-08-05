Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4061B6D08
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895751; cv=pass; b=jZZhCy0JQA/zsfqmFZ+G9Bn6OuZoDGVyupkJUm0G9yOk70rbfd9BCBUapJAwyenh1gWu8AL/xG543KDu7rvmgSUUkqJen4OcXQsY//+2HL6g/eU/Mt+87gJbH/GrmEWIQ4CmKZ3UDQti+RBmBnFkJhKvrskkow/Yh1lDODr2MG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895751; c=relaxed/simple;
	bh=jeBHuE4WTkVQtqC84gsWAKgNbBisvSXKUun/omE4U5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADYY6P1R/gj29F62l7U4Ixs9q+7+79bhokKZK4j/N/BIEPisI7zRu8gL1UdfQvADyee9q4LKVCLF3Oryg+T8elWKC6HGi+bjBxt2Za7DqWzYMN/xm7nVVeUDPMNUswyfpqzJs35CSIsMaFh2dxqJXsDu4NK1rrH+zgbkBQpzBek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTiD9yFj; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTiD9yFj"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cf70de986so186657fac.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 19:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785895748; cv=none;
        d=google.com; s=arc-20260327;
        b=DEyiHC2WZLgldVTug3cJu4ZEL6dEnXsg5q87wk2cFjld0tyTxX8q3Swl58ZNTtEFIV
         oTv9G1zLL676b+MgsF9ePkZtdSWNYolltRz+hLFiJmzPEaIZgi2GC/8vK4cAWk2skJC9
         Ppwzi9S8hWIuO8fJLc8fGSUQ6wl5E6WYlMoxDqUsUngG0hHsg7Fs6xcf1b7o8n8LAw35
         Pa/aX/k4p3N55zzr+UHroCeYxRrXFXJOtX1Ft918CRhmYpVfpgEXcQBnsGI/FzIQUWQl
         x4EGpMpU/3Za4KaA85lzWxsU+ilewXc80ylUr3TXBXFy5+i5fEBHlQuzmJJgX96rSZEt
         2maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTvjx+YN7BLrrvexWtp3Sl4BEGcFqm2fPZo8y/D+ts4=;
        fh=ICMGqCxLRBXqgt9/ZelzTM47BRd0yWLv///G2eV5euU=;
        b=qApaVY3UfNggktXwtEFer1Ky0yUrEo0s2ESm92IAyoiIo289mcQoDrFWyUGZ3GoiRK
         Mv0xaA9TRr+bAt+GuA4Azxy9j2MQxnYwok/mOPKND02fIXjpSfJ0oUkkCXi/qnyguA5U
         tN7SL32VwdL3vk78LaduCL4mMsU9nvLpJ4+m714La5ZtzZNUrRMrQqeXdvliD56tWV36
         WBUaE4fR0asFJbbaLMvMp97n2NThly58FWjLPKATIHoxsoICz7KMlgiqTRY1N8LGMF//
         vTFf+WrN/qz605CdVquSh8GNAs89/PmVpy26CFpiDh9bkgj/yolIjEmIiHsxgTHFBXcF
         mhtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785895748; x=1786500548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fTvjx+YN7BLrrvexWtp3Sl4BEGcFqm2fPZo8y/D+ts4=;
        b=TTiD9yFjHLWUGKOTv9FOkSGohOKqKFRxTZQn5BkJKivu6BKDbXaDvrmn+ErZmMDZ8n
         Srj24c1etsMNIBP3spuD7sTHP5hQ1OiSajMqMnxFUuZ3Lp32G4gyhThkQMW9mXwPiGKn
         D81p7sd59MEzPelgnUtrEEwdfLCACUNu/n4RqbdT27krcbG/BXHA9Dv15QFcyLUfEvHu
         17XsrSvBjiQFwBiX7NNzRqhfpVLQd6pZFVh3nOeaQWMvN1AGZ+nhuuEHK0oFHMOozd0W
         gzkRPUvcFQtoebpZWkoug/DaSgDfNsnE8SK12XnsrL2liHJbqtL+q6Rlytd/Mhy1Yf7P
         iZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785895748; x=1786500548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTvjx+YN7BLrrvexWtp3Sl4BEGcFqm2fPZo8y/D+ts4=;
        b=FyfKddFzjst/H/t26QthhF6iIpusT+D3I8axQIAA4hr/hWYL7q47vbZbmzaANNEa43
         dHyg1mebXZ/MbwZnXkZ10vY2W+qEECc50l4yWYlAeSmQkGBEMRSWK4QVkc6z4FhtxZF4
         V5ut5GNcnQyAtIcMltj7bfbwjmPDKnV1aGWtGSpL8x9XynB0J8ZH+ggidwq8b9L+lF9R
         z7Avplnelb2MVuP82X+NtBds5O7Md5VdY3XBTPxBuMX8WKzvj1r+HjGvpdIGjn5q5E/v
         7R41ZfU3RekCTZYdforYZoxyxbkc0k9Z5aCuk7FzmfU3ku+YJMPqeSJ8m1ePo7ELEzSn
         mDkQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8yTzCjU7V/DxnFmmg4CLfVgA7GPd1dGiCOl06yMcVHgk+fwWltxBrWqoxi36SbozUfHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4eOiypW8moZgKWyGdB+bvDlIGEdSbClVi0SOEP4OlUkq8JDa
	tQTrWAjmJ9LyYQZyXLwAH7mXkE4XCO4bFimFcUmecVjjLKv3hzOcaMUpPOmMaFG113Xl2dYkJrA
	w0xATLj7xAA3+c0L1/7mDXWHyjjWncmU=
X-Gm-Gg: AR+sD13eO7Y78w4cSwvTQ5mKmnQmFAyzkstCgozwmnR4EI8W20fb6CcF4Z/Y+ebQXBN
	XjghYmqCM2geugUBFW6YLU7AhbaohEF6Qbt49FiTB6XoA784dotwEwU95XJw/d1Xsyvjy8XnBU7
	hrmrGXJ0kJY0M077891haeiNlq9vvKJaxoJG8yqs9Onr8xLk5BAW27paKKKdOx/UBsmhjWbW8Qo
	bWGKl0B/x+afGOsOF1LpsMSTmMEVx4z09H3oWU+4yl7PsvVA+WdgJz9BGG7TBGDKDzr+SbHptDM
	mKnZir2cqfPvp/QVGk0VJmAvk4ia5dADR7gSkSXo+GHbJ0Ow4LjtTZHq
X-Received: by 2002:a05:6871:341f:b0:456:dbed:6b60 with SMTP id
 586e51a60fabf-4599ebe029cmr2013136fac.1.1785895747749; Tue, 04 Aug 2026
 19:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729022837.355549-1-chenguang.zhao@linux.dev> <20260729022837.355549-4-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-4-chenguang.zhao@linux.dev>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 5 Aug 2026 10:08:55 +0800
X-Gm-Features: AUfX_mwdkTCwcDmta6unYyTYXaaR1C-RM5YP9h5aDlMI8atqWS_kk4zD0pF-MNw
Message-ID: <CAEyhmHQbSGCdkjvncjZ7kCWpmBYJasViNtTQdsVi4eb+O1h0QA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] selftests/bpf: Enable kptr_xchg_inline test on LoongArch
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yangtiezhu@loongson.cn, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:30=E2=80=AFAM Chenguang Zhao
<chenguang.zhao@linux.dev> wrote:
>
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> Run the kptr_xchg_inline functional test on LoongArch64 now that the bpf
> JIT can inline bpf_kptr_xchg() with correct memory ordering.
>

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c b/=
tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
> index 7def158da9eb..1215d6edd590 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
> @@ -14,7 +14,8 @@ void test_kptr_xchg_inline(void)
>         int err;
>
>  #if !(defined(__x86_64__) || defined(__aarch64__) || \
> -      (defined(__riscv) && __riscv_xlen =3D=3D 64))
> +       (defined(__riscv) && __riscv_xlen =3D=3D 64) || \
> +       (defined(__loongarch__) && __loongarch_grlen =3D=3D 64))
>         test__skip();
>         return;
>  #endif
> --
> 2.25.1
>
