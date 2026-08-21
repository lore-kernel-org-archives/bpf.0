Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246738236F
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293296; cv=pass; b=JB4CZwq++oeY3JA8k6S6yFmJSrUoc+y9FVodY052rUKmiRcfXZoRuNyzL4DwaNF7xaOMvnYabM+nAEEkq33tOHR0xiv+xlU01xK3skW0DmZLL2xdKbO3X93iI1URGOrrbwOSrp4gaE/N26/+QHQLPcGPhr2GwK6HPJ+CEaLRrMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293296; c=relaxed/simple;
	bh=67Qp5oUnGYfJE4bXm4CmyW/zD0GZcDQ/0nLUWxoKfAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihke1F4oZgox5TmfqiVo+mPMgoH/RwYwpD7n6fENUrARx0C+DMJv0GnR3RnUANS3P8YSH18aXMYDKbxVtN/ToXbffFLhZfxFv4JvGJuBz8cYZHs5KvpogwSDRS0QpeQLMWPaB0Mp5/TIZpLfw4YhrBwiMJUNe9pR+nnzGX6gX2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=wend5obP; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="wend5obP"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a449c57so3715861cf.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 23:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787293294; cv=none;
        d=google.com; s=arc-20260327;
        b=CReSaHAq7k6E7pWdg8NYtukLXkH54nq3XlYXwowQu1S4i9z4mthob7ddT3kbkavUxo
         2/mBR9zGnHsxYl9dgO8VsTYTZb/hKnin8YG+kUTyutgx+qFx0sLGijMn813TMo5pwdm+
         ZLFXICbU09Qv4ZkNe0zNXWzjDdIJz1FzmNVweBfY/ISKB2UsFcQpXUSCAs6SHJ7OgA8Q
         dmyb6VsL7F0Fvw5f2i7y8FTMS0elfn/o/ZFGyDsqJrFuWKtp9b1B075XJueR1ZDGCXcG
         yJDv0zxIVCtdODDnorMGiZHHHlJB/X62BNTpsYsqe8wuEylb7vEYUjT0varAeRAl+Tov
         vWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67Qp5oUnGYfJE4bXm4CmyW/zD0GZcDQ/0nLUWxoKfAM=;
        fh=NiiL9rfNSSG0m5Qxgmufc/msftPEeQN6NXB4kqc02No=;
        b=SxdGSFjxjHuKJdhv2+/1xQHvSVQ38ZE4k9987lLXnYEHFqCpVg4U6GT29W3HkkkHZ7
         7Y24yElRGYHF7OztIWKK4OsSHkoT7V+J/kvEV0EeCr1OstsNo5q9opKEtjpJIX+13CvN
         icWEuroohV9+N1wXTe1HfmIXi5AKEIIsgLeaaU3o9Aaoz82YFRxCrsxowUNxquEWn6fE
         ArRqwXQEUKuxuywNCVsmzIGVkuUjT0vvwXsFfzSTA8YFkQr6roOBZYK0XY8FboIghy0E
         jx/SV9oUA43s2UPRTl0PRbnqwgM8X+tI+xJd8308krvslqMdKdM28R1wwOIRyG7hUAq/
         J4vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1787293294; x=1787898094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67Qp5oUnGYfJE4bXm4CmyW/zD0GZcDQ/0nLUWxoKfAM=;
        b=wend5obP2zfozN9qJx2XfizUk6vl7JBOWt8BZfjf1xdcxZaF5PHbrpTOZ1U2p2Q62K
         axVAd5IxSEY1H0b/GAGjk/NUJ7W/oleC4R/6xlcZrePT80Uf3WtTUK4XidDN2w4zDZHe
         MnRBJMF/qSUv93hSR9KxhzDP2StI9hulnwsWFRAxfmjbn7Ka10WuhTJki5Y2GMTfzVaL
         vTkB+bBy/iw63QRUa4CUQMX7aTeu6WMN8UGU9w9wYcAPHsWo66GhcsUJoCV35ZMUkalV
         6TPHKVJBo7BSvhSzx0tRwXtlMfUnYCIqFETAqLyjCtaPMlOq/B8Pbfk6dWQ4tg5AbaKQ
         Ne+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787293294; x=1787898094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67Qp5oUnGYfJE4bXm4CmyW/zD0GZcDQ/0nLUWxoKfAM=;
        b=VoBydkSQU090QWhXb4m/L6l6aG7p9dXZjrLhXxBB1V5J49I7kEPOxUARfLb5aXJfb6
         N0+/QZMZ0kduUwx6UPH52KOE38vO8g1bUc7vUxJemm3SnnEF18m39xrGjM6B1idvUhqh
         sLRv9N4oWaq87x6CxQypR8kcRW/yPVSXUA7/0cv0lw4PbShtff+Py0MvW4KtLeS4TUL0
         cegUl1vwMG92l3ToffPZ1zgV96oorf3BdCkdD22ZZscMZhcXTRwyATaWb2IVTXx1AdY0
         GeoYRU8TEzZgWqhg5NtgNKQkat7/Tk7NqmgzX9DPG5gzEwPMuNAte65MNeegziupB4kO
         kE5g==
X-Forwarded-Encrypted: i=1; AHgh+RqC8Q1//Lo/wBZ6zVHFpv1aM24X32ydz6sxolZUA3MU95qgWgQSuUzFa+fML/QxJNQSrb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/XsSDsPgp3P2/q4QdOrAMkr/kaSr29b3VE71Z3xcMUy75owT
	cOELFIvUiI7B8p8AYqptyESqeS7ZPOOEd8seDqsB124P5K9ZtePydU3uDlLdob9nAl04edaRLDL
	WfVVvUKdWlkjg00/HYzh+iQes5J9srNcCqCUWlbb9MA==
X-Gm-Gg: AR+sD13DuQEFsOVsGc1LYYL5kaji2DpzTZtS1gjViRaVPdCslbx3ZelleBSivQxKDVz
	3vy4m6s04dzpEvrhO9EJVQHCMXNUAtIewA+PV2IbxYK1iWB2Ybm074FpCIXmXV/9QYCSZFSFB62
	4uXIISIpQbOVFtYIBd9uu2ZtuN2xi5wZNwX5avUAWUdWj+GgBpJJlpt1oXNpfAJeh8BGDh53RUB
	NFO0dH2+vF9AYb9Ob3+wTHwvt+bJ2r3FrXLuAUmH+tABhz7xzIjbzxujhF+7ML0+lNIu0vxGZmP
	QrrC/YhakO38tskJJrTRkYSSlQ3hAwGn9XCo1C/1I3SU
X-Received: by 2002:ac8:7e96:0:b0:51e:e5a2:ac82 with SMTP id
 d75a77b69052e-52df59f1866mr32825491cf.23.1787293294195; Thu, 20 Aug 2026
 23:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810194215.3754591-1-main.kalliope@gmail.com>
 <CAM1=_QTvdWzBpSGnoLV7wiW0dsn_nc04V8KnYuntptQ5mF9Pyg@mail.gmail.com> <CAJZwKkis=3NGw9At0WfiZaRYEoMPbQfqJKN0e+vtRDvp4VY5Ng@mail.gmail.com>
In-Reply-To: <CAJZwKkis=3NGw9At0WfiZaRYEoMPbQfqJKN0e+vtRDvp4VY5Ng@mail.gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Fri, 21 Aug 2026 08:21:22 +0200
X-Gm-Features: AcwNN1VUk7GQTVjN4D8OR1j7mLXVuiJC6bVhhR77XaCTceK3mcp8WAPe-tUzXYE
Message-ID: <CAM1=_QSk9W1z6mT3EdKV=_cbHm9d5FH1HVO6CFjHcppy+s8OOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf, mips: Add signed div/mod support
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	philmd@oss.qualcomm.com, bpf@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:11=E2=80=AFPM Nicholas Dudar <main.kalliope@gmail=
.com> wrote:
> I plan to post MOVSX today. For MEMSX, I will base it after MOVSX and
> SDIV/SMOD and call out the dependency in the commit message. This avoids
> carrying a temporary fail-closed check. Does that ordering work for BSWAP
> and JMP32_JA?

Yes, I think that should work fine. If I understand it correctly, I
would then add BSWAP and JMP32_JA on top of your patches? I plan to
take a look at this when I am back next week.

Thanks,
Johan
