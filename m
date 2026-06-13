Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFF2D9ED1
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373228; cv=pass; b=Eh0xsOwSN2THNzFoBZRmfWaiQJJT6JHQra82kZS8XWnnB2HANqeSo/I0cmpIkyZlF2xwYZmLsrLsqkeHd+7v8mVoxsij2wOoD76LAe9xVm35M24LuzebZR7PYATZHocNMWRZoXaTqRZPlN5qvzN5zsAOHD3TfgchevyRe8VhfsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373228; c=relaxed/simple;
	bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr5Z2ksTNcy3WEg/+6DdL/lXeTK7nbWExQey/XVt7S3VGKFdlsfn+/7XXgJbgEy/UcoUN+VyQZji+Puv2GUXVzZ2wkeudxxpeI1OBJhHJ0paMJV8vmDh3AlgXYUTF09s+oANdmsuJSiq7SIDna0bHpB/pAITw20jhCq1PW06ank=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OexkXffG; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OexkXffG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso1246554a12.2
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 10:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781373226; cv=none;
        d=google.com; s=arc-20240605;
        b=XFJ3kNSBM/gQxg75pmwMJ8Bk4qjgMs1viiX/L/7kxod3JMYrqUlgw4CJOYdtRkNuuP
         AnGkQ3fqNJyI6V3YD6GebYsHUVIBy/5I2G0J17Ty63RtIr7Jk/FnFU0CMc2eTBXW88Kt
         B5IHHq3NtuGt8/F4KNM5tshWI2TFawBlIIkBhxYDPajtaXWPCXwg3qTcUlzWd1jo3ET5
         0KUspIgtGy1gcgTQMfOXElRAZIAOzz0z97smm1YvYNHbiBlpnPogY99/Bs1lW/6fO1GA
         /uITcgWMefrCGqtbZZkGRVW1WZDNXjrQyCDIqfSQIk6hlTKuLqFxBYaBRsBDghCFrQww
         Zsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
        fh=I3Zdq+sBtJm01Atz3mSF67XvVAf75jx3ZsrrjaWKFhU=;
        b=XGuBCbgnjdURcI7ii7f5o+0wRc9QaReF7F+Ic4LXKtn3QMLzjQ5QpWYjuWv4v9sIoZ
         Y0K8nT6fBon5aqIsgY4XpmJNKK0No5b2aV9q8ZIGZhaPtqHGsj3MZo9Le27UGPjs0jZ5
         cdnHLJg1DqfzfmKKqz3P3hKoWB9kxmQmtneaujcMeSXtqupl1q4E1W35HZMqKBAWunvp
         mpWbUX/+Z6TK/uXcuhGUKnpRf6wv/u7WCarHWd9blpgymmMaMpFhrRSSUQFpto0743cw
         eO74uLnq/WcAYW1Q4B8BJ/CwWG+8UNUc7z0IjqN5XIa61zlDIOXGIt3CH0gVmNAdGxQY
         QUjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781373226; x=1781978026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
        b=OexkXffGeEZa7FMR2Kr9By6VvGTV4HKf7rbZtOaIBuiQqRxP8BqdeFsTAhUYuMDuyV
         wI/Kc9ATBTeWgAqZgvV1dTK32g4Mk8zCJlvW7Q2eTtp4ZOC6PnxBNu1U+XRdXRS8krRq
         19i2wpqsPNlOIMaCXmpmTg7pEnj/v2O3gdpv2q/gMy66OJ5BABTDJFDfNob085tqYtZO
         TFqk/WZRYI7DfWe3tibOPNcjqmqnLkm20pzui/k+w4VOAFVMMsxKwXp1xQMQX8kMsxed
         nLa+0BtxQdKLCkuoQcd8x3wuM02EFZkkfSoWL6UAcdQkiazCIi55W91zx0Y72DoAY4s6
         iFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781373226; x=1781978026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHOHNOyUyYBfHV0o1Nf3hriSXuDIGz3neaaapYBjf38=;
        b=PAY9WGpdDRKYv4qPmDFAGKcwkKUORBWf42s5JjDuMhGMSjC0axF3PwsVPN2RzCZCBB
         rcoMs4zUUbkwzlOtn+HB9i1NNs/0vJhlJFd78J33Zwu1rX2Ph3+nMZs4dOy6y1Oj9izC
         VTSVtvDkHlWZzrO+7hrn5v9PT55cRLJwUheaXd7Bs34yU7nfmY/K1rXQBRa+fre1gS4Z
         zZvmyhvojvGDVh0FNByrBUIGsYtux2R21v7DvlurBYdSFkhgJlRVcpQbp8faR5prCpgP
         p0N8cfCczV/pjBcTlKK8P2WNuLVTPjii2NHu2G++WkslB6ocVHandHCrUMacTDrVuGG9
         /A8w==
X-Forwarded-Encrypted: i=1; AFNElJ+Fv1Q2m02/5lBmizWIatsDZLmvYlGrRIyslcuAEM31oCTd40Sj5AGESUoOJdTbAM2J1tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvg8gA0EJh4Wips+aQPRSjo9aUMq0Xr+gfoaGmrTEXptUiS9Fq
	ZL0YREHq8tcQ9w7vTu/cP6bvvT3YOmoFGv52SOm71bVM4EiDVOdB2hnue8wRVK9VScGGuKYLkiD
	T0AaT1IJNp1cXk02nyzvmfF60qEmS8OA=
X-Gm-Gg: Acq92OEZU/Yt1iNuCuIc1sIIvPdZZbHWEFsmUwSU/PNAGo/tQSd2/3Fm9S9WQI/y0se
	/ROMJBSIX7BkSVdL5jKiQxe9T7npqqE0z3jmpd+iGFgsJ9nsX1WF+G+Yk4jR6X2TtPMPDQth91M
	CdI0cmiUt9IbKGp5n/wAHesLS2Q37NbQJl8Wsf116zsQfo/59WmnK2mkQU8ZGYjliyKQwsjmT8k
	CvuD62pSwVgI+bX4fIHFhWPPAV3mbNd06DCs0+JBWR6UW0NRelLR9X777JUx6Rd/PZMzoiRfsKg
	g8ZjlKX+YqBJAISXxrsXlwrD2fyBMoID9ARm7zFsNosh/heDxsgjQhaTvKnqBUgr1B60Y1iZ8nI
	Y/UsrcO3UwMa7ocoFs7CY2UFlR1amzGOfXM0=
X-Received: by 2002:a05:6a21:487:b0:3b4:b2d7:c146 with SMTP id
 adf61e73a8af0-3b7840eb437mr8380305637.21.1781373226415; Sat, 13 Jun 2026
 10:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
 <20260612114032.244616-2-sun.jian.kdev@gmail.com> <20260613102549.0061a875@kernel.org>
In-Reply-To: <20260613102549.0061a875@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 13 Jun 2026 10:53:35 -0700
X-Gm-Features: AVVi8Cf92xxqHllCzGcs1Wzm4G1Syt1-QC_TVzr88S1xZSnhQVts2Q0JSSNR-Ec
Message-ID: <CAADnVQJyOR0hppTmhbTRS8Sp5ci-L0fmQ6V+R9eiJDop_95rVA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on private skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sun Jian <sun.jian.kdev@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 12 Jun 2026 19:40:31 +0800 Sun Jian wrote:
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
>
> I did not suggest this

ohh. I didn't follow discussion closely.
Do you want me to revert the whole set or just remove that line?
