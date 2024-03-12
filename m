Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1C139572
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710270786; cv=none; b=EQN0Rh2qQOosWiKDZHqh6Ro+lRW38iSe/3lvRZ/Ycle3cZtekSEYjXoJGc8aJrdDzpznXS/rxF2t8UWqr5bZ70XwVJYMCrfLhdJjPj5Osq292VKAMzEMdYU6NzAJJ5oPrIu4PRkLzqvByDJRx4aeZ7OdbBC6Xc3zHVdSboYa06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710270786; c=relaxed/simple;
	bh=Amfo1zyY/XMgZfkM64p7BMIVhxMGSBZtC+3yuV7dH0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWNQaNa8ws/fQAc/OHjxwvJG4ZvpNqR2pG/Ao8Ig75P62I2WDmtLzmhVKvTAVVDjUQdw95ZHZbP9z7OWDL/AvIJWR61hxDayJXwC56n5I9V7ZKuQa8BtKK2jUyb8Xdc9DX23ObR1tMrTnenBi4A0j2fCgsATHtr1StmXcOg65pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=FKnLkNPQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="FKnLkNPQ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5131316693cso306394e87.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1710270782; x=1710875582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jG8wbZD5AfK31iZyN31p0fO15RUS8zjleaircOhECw=;
        b=FKnLkNPQGPH0aBpXuknz9S5g/N4I6NCuu3xogMutRMb08FhHuHHuFFPr8UssL+VWU9
         /2MLGlwe0CKvdQPMe9QGsh3xe6GVRV0q5aV9TNmrEUkQOkUpkuXV+2Ss1FGy3e0/DoKe
         MZgynV0Xx7i3oW5QNYsJLkONFqKWnpwHqUU3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710270782; x=1710875582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jG8wbZD5AfK31iZyN31p0fO15RUS8zjleaircOhECw=;
        b=UmbExSof4E1qdobG2DaJFtzZThXkqIe5wYIoNZKc4+rWY2kV08ZCCalTA+vB5575WD
         4CsF3fjecFlkTZpq0eIEldMwqTmqtAIddkyMMq/UfTk5eafOjz+9IyUv1nqyTNXh2VNR
         pkKqsAD0+ZA2jgfu5d1Xw5DUAgOBbROlcS2bqFshsbkXI0BmP3lzIfb+xn5mEgFHNFH+
         QwyO1cO65OJAka2DE6/7MidrQ0DjoKJjJQLSRjjx0uklLm2QEiTN6Cjjld8lWFRH1W21
         SPO6QTQpJYhjgUxfFMMXCAfZd+Fad1WWzlmeCRbAHFHiyCkSTKpIbCpII1IZn8//iXgc
         ZwGw==
X-Forwarded-Encrypted: i=1; AJvYcCVdcCj8uP4iFLXxFeZeyIFSeavmB72mogFTJu4qL9QVoQ5BbQmtYj8l5hQ9xCRC1puyzkZaHzeh1K7GAyVrMEmKGzHm
X-Gm-Message-State: AOJu0YwOimcpIVQPnFRkuC/WD8UgGBu0NtutP6JJwJzpExlEuzNyAA/Z
	CT4UpGrYutbkv2aXXQPc8uk8PgRDm1UqQZ6GwYKLN9ilHK1E8sItnGyK+Oho5FeZr/xn8MvARbP
	22/azScSgkQEqLV04l9NIK4l9fahe5xJqgsFi
X-Google-Smtp-Source: AGHT+IGPN7MP8pGrBw+bqrQS1y4hzsPicRpPqb0kh9lC4781+mVZ8XqAvBGV25wdDyJyi7TeYTLFfsuHZmR1lT5iWJ8=
X-Received: by 2002:a05:6512:5c8:b0:513:c7eb:edf1 with SMTP id
 o8-20020a05651205c800b00513c7ebedf1mr32508lfo.59.1710270782277; Tue, 12 Mar
 2024 12:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312012053.1178140-1-pulehui@huaweicloud.com>
In-Reply-To: <20240312012053.1178140-1-pulehui@huaweicloud.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 12 Mar 2024 12:12:50 -0700
Message-ID: <CAOnJCUKF4BWfX+Z6cQLjfFKc5+REsSXWiVvcHadrs-=z1b6+5g@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_*
 while not supported
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 6:19=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> RISC-V perf driver does not yet support branch sampling. Although the
> specification is in the works [0], it is best to disable such events
> until support is available, otherwise we will get unexpected results.
> Due to this reason, two riscv bpf testcases get_branch_snapshot and
> perf_branches/perf_branches_hw fail.
>
> Link: https://github.com/riscv/riscv-control-transfer-records [0]
> Fixes: f5bfa23f576f ("RISC-V: Add a perf core library for pmu drivers")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  drivers/perf/riscv_pmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index c78a6fd6c57f..b4efdddb2ad9 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -313,6 +313,10 @@ static int riscv_pmu_event_init(struct perf_event *e=
vent)
>         u64 event_config =3D 0;
>         uint64_t cmask;
>
> +       /* driver does not support branch stack sampling */
> +       if (has_branch_stack(event))
> +               return -EOPNOTSUPP;
> +
>         hwc->flags =3D 0;
>         mapped_event =3D rvpmu->event_map(event, &event_config);
>         if (mapped_event < 0) {
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
