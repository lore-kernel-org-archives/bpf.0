Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327713C3FC
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272592; cv=none; b=r2u3bC39+1Rb5+0aR/a8Kn3jAwa1/HAbUwiIe3QaQMrx/kwauaXhrK9pNLhSIu28DZIFG46EWDAUJeRM5IF/9hLPUWzBm38NWF/VaeSc6Ny8Y+rXLug6alMK9TQhRQF5oVZxKjKZT2LRWa7O5jlOD3eSgzEh2Ma83g8vkUIEc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272592; c=relaxed/simple;
	bh=ZVqrIv3MDSsLdNpjcykyDt18AMWPbB/yOL4TFECNDUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clvApCfvfhkhiBW/blaERoTQa3Q/jh8oXyrRa9t0MncOI+O/qug5GmpQalIJP18MVZBkdqUKWI9EsHx4+mRtV1uUAIVeNoTfpV7P/IQ8ujmwDGWSbWWhVH/Lk91kvUlEnLEIDakyPO93nc5BCK01DXeXz46buE6NRIcYET5GUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=020UjXX8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="020UjXX8"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6157c30fbc9so16163227b3.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712272589; x=1712877389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVqrIv3MDSsLdNpjcykyDt18AMWPbB/yOL4TFECNDUc=;
        b=020UjXX8TCmz4YfWnIeYflzYU6Au5dDVpnprciHxX8T4becXUZ8Mya0cjXTlCrIWlZ
         IErzPEFwcbfNrqDhi85D/iQWmhAt0R7Y9P5DjkcG0tXVjOp7k8iItZass53bJlExkSiA
         CC2ZJUeB+goe0dxUXRZy/XpMHQdYnYYAOfQ9hpZ5FGOc6iFkGdjTizaiCnG7l85jpiOY
         wz0cIYkhXeJs9t6VyYCNJtbZ4oHWmE7xExrBH5hsEte01bhepkeOzzRZIugcX/uNH2/X
         U0TPNQxhSBV2Va4/Oo6yFFVFwxOHbtH589F43cTsZWzOvSWMpG/I1EmB3f492FgreVUx
         Aufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712272589; x=1712877389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVqrIv3MDSsLdNpjcykyDt18AMWPbB/yOL4TFECNDUc=;
        b=XrClkR+gRXrgqz8gzR4OnOzd2zloN/Z15Mxv9/jJ5Q6zQmrElGKe9au6j1ViEEgyhJ
         /Fza6Itl8stw8CSyyqeDlYLhmSY8la8wkTtLfFgUJ0koCMeZbwl+1FYfyR/F6yoUTvvJ
         fymDxX+wPXsX971rJCczvXXMzl4z1R1jlocVHAg+NtMlSKOlPIk30VpKlEKw7FjutxzR
         /eb1M2tUCB9s/MUF3WLaFbwZ2L+xrkX7hGn6UJ9pRKTnb3WYq9/HcQOUMjdOP7BCWH4a
         P3c+LPHo2v1UjNCg272Um95dGy92iFuwpyrN/bz+CxD4zILEht4fp3q/+MaXgodaBuUA
         d5ow==
X-Forwarded-Encrypted: i=1; AJvYcCX2GL+Ai8pbJKKKd9WaJDjFxpg1KrSPmR25i4a7t3p/aBt4Uv68+lr7VWf2TsBu1hmtYapHPZEF++0ZXzfpx4cieW5q
X-Gm-Message-State: AOJu0YzdmfcCOzQHcYV8yGJsvfDTGzPcarfAegawCtI2aVaDs4qXkNKT
	3kVVI/Ff4oksEA1P9YPE9x+/xx8Gx05C6pISZHJOkGBgSfQEGOmZ0NNFSu8sla+ajHFo7uvAb4U
	YuWb/QuuOkm8WYIPCQWMARR8Co7XKhWSIx86p
X-Google-Smtp-Source: AGHT+IGLyhdWdwtXPnNQ9QdcPsZ3gr3TztSWBZCu5HQda6NQNZ3TPxhzjrVD9iMwo3YAnZ4H3AzzroJJwYBu9egTMvc=
X-Received: by 2002:a5b:148:0:b0:dcc:8f97:4c42 with SMTP id
 c8-20020a5b0148000000b00dcc8f974c42mr3911903ybp.13.1712272589343; Thu, 04 Apr
 2024 16:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122338.372945-1-jhs@mojatatu.com> <20240404122338.372945-15-jhs@mojatatu.com>
 <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com>
 <CAM0EoM=SyHR-f7z8YVRknXrUsKALgx96eH-hBudo40NyeaxuoA@mail.gmail.com> <CAADnVQLJ3iO73c7g0PG1Em9iM4W-n=7aanu_pc9O0t4XrG5Gwg@mail.gmail.com>
In-Reply-To: <CAADnVQLJ3iO73c7g0PG1Em9iM4W-n=7aanu_pc9O0t4XrG5Gwg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Apr 2024 19:16:18 -0400
Message-ID: <CAM0EoMn6Nyu5AKgSERZEtSojvzKN6r7enc7t313G9xBvq-bcog@mail.gmail.com>
Subject: Re: [PATCH net-next v14 14/15] p4tc: add set of P4TC table kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, victor@mojatatu.com, 
	Pedro Tammela <pctammela@mojatatu.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 3:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > We will use ebpf/xdp/kfuncs whenever they make sense to us.
>
> In such case my Nack stands even if you drop this patch.

We are not changing any ebpf code. I must have missed the memo that
stated you can control how people write or use ebpf.
The situation is this: Anybody can write kfuncs today. They can put
them in kernel modules - i am sure you designed it with that intent.
So what exactly are you objecting to that is ebpf related here?

cheers,
jamal
