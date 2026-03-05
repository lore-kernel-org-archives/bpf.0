Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BA361DCE
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740483; cv=none; b=ng19kXImNoMdeTZxYzoUZnGkL5r1ONk7jl6wz9VajuffqFDw0vxa0ZEeClnTGWbApTf+HJjaNRN8/NBY7TSoip2z2NGDI2snJKVyIP8GTzkovDWcHnYS4Cq1JqXX/onvNDQ0+10SsqRsRJAcb9MPgvUZlmFwTiMcQNqPR6y5l9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740483; c=relaxed/simple;
	bh=KXjaeO8TBCJWOsx77BtNaImSzKSFsBBLoI/vCV6xqPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNxQErs5/DHz993umvzE9rHn+PIMRNfM+IGWMnDaSR7oa1rlpEyevGvpCK6NOUM5p1GL41m6uwG2l/eFv4hhKuqTSZC2m8+cRiVs4VJOG1yuRAMW9w6Q0nJvm5/wCOMjr6PzSJRe+/SATjVYZuFjoS0rPZi0Wv0RNiblzG5SERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmchPgGz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmchPgGz"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb39647a70so812808685a.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772740481; x=1773345281; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tef0lFKtuCFCTOe1otFjNe5uRz/BF/bwXpY3OD/8jqc=;
        b=OmchPgGz9e1y1X4/xZ26ItsCDu9rd2nzYw7p6tVTUgmjOZmojVWRxTrImiQmckW/38
         ehU9RG9fMdrrVpS96zAnmtI29kyN0RHbrLv/gmtB6wr/OqyG6SWXBerz0YfQKEiFV1NF
         1Mi4M7pxqMEZ8/IWI1x+hZXXyx1i8DcsRMEzqYOEdnzZJZToFQxyFk88cMYX2NZNwx1W
         H7Uun01cj9ND2AYg+28HJhV6AVjM4d34c36rDlh9MMsZg1S7kbnqGA+N9Yx7KiZVNO9n
         3jANWbPM6zmBWGDZNqn9WH8187RiAYkCmqt3nBLTtCVe9jgrJfMdU8h9PvWATTdWcG/B
         tthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740481; x=1773345281;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tef0lFKtuCFCTOe1otFjNe5uRz/BF/bwXpY3OD/8jqc=;
        b=S9ZictsskdW59PqGh+4JZD3hWf+kFkXAyqFUxcOmnni0ZkKDUShIkk4Au7UrpzJ4E0
         Rl7csVBOX5UBbLIxtjaJ5MkyzhPN6N9LUgE8hFaQatnQQRJ89mWh0kDfxQ6Xr1N0ewkr
         DXluT6a77EwzAWsfqouQs5pPX6PW7yAXZmp96ujsVfMHqUxXg8XsGMBOKXNS5/zNnsEb
         8BAQRjrK2cV9SDd/QkI+FnHq9pchvdiHOtjLfj0eQW2GhpF5lGETGmY9irCFc6lGswT5
         USwS0kndy7O5Inq+uj1A7CGjfmhRr/QgmmuN79b2Ll5yJMR0uh2I5QZWY/WUQf7Y/pwd
         V90w==
X-Gm-Message-State: AOJu0YzsGVPNLaM7Y3I0YLMT6B9/Z32KwLSpD+zUI4WgNhfWhrkSbMlQ
	UxHGtdt2fXNIlBealazNx+n2Ic2WnhHv7LaPAw4cGTtA8wezRQ+L6PPImbU3Hg==
X-Gm-Gg: ATEYQzxy/K7H/T7/61DupauYJRmDo9rCqzXfbT4cQkfZD7Ny9LQrSo98HFBEk+j1msx
	iKPvIqfhEAHbndqhSHcew4DMaxyd+55jcBV/jPvsR/M1ese2n81rDcCVBy++w+y9mRaLdoXItX8
	1NQuyMJdUBidVVMu0pj2gNylRrfJF1JIqVjsM7IXgj2i6kRcd1r2PfDw5wTsLnn9TLgjgTnVNuN
	bpkDEskQUKAp21iyqZJ/ECuFDJCCDDFJGsyMca3ajQtugR9ziEHeN2eaiC0RiytUKoc1rlfbCZV
	qU1gMiwsAs7UY1sKbcZpOKnq++aAT6ojAv5IpE/PEVWdzmck6dBvxfeVAoiQCmIZLWYe4ag0rmY
	lHyPlX5xEphBFfNqfDBh/ZwU6zCBeRjKxtyRUOITwlfzgvoZLRA3FT0SrlJd4t+DQcw2vrN1LHV
	3AJBqHaBqznt/gexevALGkP/Q6jLXpDpEYcbEK9ggYeQsad7O2ZZz2ieS0SOCIn80=
X-Received: by 2002:ac8:5d0d:0:b0:4f1:ab66:7c43 with SMTP id d75a77b69052e-508db46d6d0mr106304361cf.74.1772740480686;
        Thu, 05 Mar 2026 11:54:40 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6541f1sm1935979685a.3.2026.03.05.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:54:40 -0800 (PST)
Message-ID: <110810cc8533bf8569d0226ab5f5735851d1fad9.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: test refining u32/s32 bounds
 when ranges cross min/max boundary
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com, 
	shung-hsi.yu@suse.com
Date: Thu, 05 Mar 2026 11:54:35 -0800
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
	 <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-05 at 11:48 -0800, Eduard Zingerman wrote:
> Two test cases for signed/unsigned 32-bit bounds refinement
> when s32 range crosses the sign boundary:
> - s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
>   s32 range tail before sign boundary overlaps with u32 range.
> - s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
>   s32 range head after the sign boundary overlaps with u32 range.
>=20
> This covers both branches added in the __reg32_deduce_bounds().
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

I did not copy the reviewed-by tag from Emil from v1:

"Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>"

Sorry...
