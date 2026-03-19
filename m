Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C13DBD4C
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932948; cv=pass; b=acNBf57/VveJC6lj7JML4wUP1x7Q0UreboUMxxF2jQ0D1WhmTyQoMb1LuzKjA6AG6F3WmoaZNMY6xmhSAtFlFjOgFzHGNuaoXC1LxEaG+lB83cGVWT8fSgRgM9Qh0OT+NcEmO1hshj7zsUGcLC/dxsDnVhxzDwsvzOuoIoOkABU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932948; c=relaxed/simple;
	bh=DqybgczmthZBh+KRCCZ7NVFiFkkZovfdbMNP1BBxjxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3nHq6F76zn0O0qmNns3QfZPxc9II0aDKG0o+aKyD1Eb7mF42a5L8Kutm9qyE61d6ym+IhElWxwu32snXYrUq2T5WWzkugn/mYxTX551SA+m7k+6AMdDHED614YmJiX0QoZ6jRqItmDN1kZFTsBeU/osTzVvZyGxcySNFwTmRhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZReFeBY; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZReFeBY"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a75818937so11211427b3.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 08:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932946; cv=none;
        d=google.com; s=arc-20240605;
        b=emUny3/fhz87nte+LBiVjCOtepzwiv+R2ZwdjacIHM7e1mW6cyS0jwFQG3ifgHPlbs
         OZIxRgNZRAAV9mssIZ//N21+U/P195Bzce0grB8Cs+eJtyuiPlLPzdQYAMAFF5iCqPJz
         XKYle4M8/ig2c0uI70YT2YCb+V8Jjynuh2TaIUUTjCN7zybUtakKBVM9xi/4YzpZiLUA
         fwBkCURdStwj4avP194lFVFDUMwDD9SEOVvm6G16NJUS63yPPEkYozn4AmfgwhIW7sfR
         hcgHJqT/MclOQBhViej32cxDa50DkJpW+tbVIslh+n4+j3BYqDxYU1lba4FcF17m2QP0
         7xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqybgczmthZBh+KRCCZ7NVFiFkkZovfdbMNP1BBxjxk=;
        fh=bCLoGHAml3R5Dc3K0gIM1ZToJHGxDFUEdtnpLxgh8kk=;
        b=M3Qz1UVftH30MnropYn3lqjsahkZNO5l/eAjunoa1/9E6GyVVbiB66I1gr8rZG72Az
         TFSVLcA8x4580aSA30XfOUfUn2KVQ3z8EC6UKaY51Z5Y2Jabbd8LhAPsT4RR8NloSPjn
         YKKi5GPnvAW3JhJhcRpQMkjJl4H7xrev2/faCLRBmZFSpieRnIU/QvQybYJy56lMFVYR
         W7A8V9Al+eHvXH0tcpSfDdlU6aweL63a//wC/A5dfJWTvLuHaYIQbaExQaxbsH7rBXdw
         aKZ+mnv88nIZQ7872iVhMjwIKams1y67aBPMspgH0pig0+9NEAdT5zIcs8iqDPudgBhl
         8tJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932946; x=1774537746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqybgczmthZBh+KRCCZ7NVFiFkkZovfdbMNP1BBxjxk=;
        b=NZReFeBYyGB3h/uD0Cei/eQTmzD1BNGWKgNQGeSaJg4sAAqrwe9Z5t4U1r5GBsY5Rd
         w7DU7IrelQPfaKyyD3Uf/Vznqzqx4OJh0KrFdkEULAyKNb+SuOONxl0uyk6GHRl4xqpf
         1T46w0O1U+36IJr8Dh0EuMYTea9N3feu9gI5RWqtUT927WrPuSCJuEQC/i1cQ1XH+EaL
         JOpI2Anc09eFc7pHPssJ0EQC9BZ6hTjxLHXYkkzSBYnrFM3HAQpNYX3A/xB7zJAiwoyx
         iKeiIQZy/XjFMsdMQd8UyZ0dcM7yXT0x7fyZlqpi5BiFfk22hHbX7SVqQaxE8eso/1jg
         l9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932946; x=1774537746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DqybgczmthZBh+KRCCZ7NVFiFkkZovfdbMNP1BBxjxk=;
        b=REWV0FpXZQ1aTelU9zBT32nmoZRuTWC6WUWh+CTw/uQS7PLuexV91M/VOB9ybfa4bH
         CSKdKUQa8oyuNgw+Uo1A19TZab98S/rnZNw6AQO/d2j6mjmLEfIavzZgbN3mz/OyLR9p
         fcDluW3Gm8zu9neUWgIGxQtiw7OwE3w2Z8dGOqk07qXgUBlUu1rFUs/4UCRrnxvnhKC4
         MMbTK4a9ISgvEA89Hv3S869gO+1eCPHTT34r3Bz5fIaaFksm9ztfk9iSHHc04Y2vUtIS
         BfiPGfjsgmjyg6mD8c7VER/+9YrZ0tG5ErYYvRTi+tfkRme83giKaU3mbmbP6FZoZAZh
         Imfw==
X-Forwarded-Encrypted: i=1; AJvYcCUQLZZdi3K0iBEHvCfu2Mp+Wjb+nyRBVbgF+7ZU/42A6g+D37FkSuDbQuJNe4Ez4pYyqkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIEEwhWvcyli24hj1QUJY9OsqmVt1nGjoan5o4HKu0f6E3amQ
	2LUORAPysfNhQNI+acgR4tDFY34+SNyPIuUtJ4dUokJ3rXKD+C5bl6eeK8B4Z7ltBPd666vEiKL
	BZ2Y71LzNiCSse0z+orMlcgLgDgJzEpQ=
X-Gm-Gg: ATEYQzwiigTeEg2lOS4KH03a+7+6dB9BuKhMOV3l1g05+V2kpFQsS9/OsMOjKgRICEu
	Y+Mo1byPvN2mYmBv4KpCCoTHS0D+wfG/cCVqkVeXmATomGfkwmY1hJNGoQC2rP0bbPQeUuPDDpq
	IdfcWbFyp64AW0xtzjwq7BN/sNEeuxAY5SGGMZ41OgNzznfCJnP0E17+/Tf/B7jQwByaSLR2aWD
	kS7s7WHjgoGOb99u6c9OOEdpHKdquM8YRR6wDoCaOqgH0MLLvTdsj9fCcBIARFejosBoXnEIh3O
	sW0EWDTq0Q==
X-Received: by 2002:a05:690c:260f:b0:79a:2e6a:1baf with SMTP id
 00721157ae682-79a7182d7acmr73759477b3.8.1773932946013; Thu, 19 Mar 2026
 08:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
 <20260319040337.366375-1-sun.jian.kdev@gmail.com> <abvYVE-CJcmRypCR@mail.gmail.com>
In-Reply-To: <abvYVE-CJcmRypCR@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 19 Mar 2026 23:08:54 +0800
X-Gm-Features: AaiRm53c6WBVfRJxLyF_a6aefA5Vc_KadnMdXrpCiaXRnUOmZ5z1Z9oEeTwJeRY
Message-ID: <CABFUUZFprcMMwoR0fY94EePRPM-DF4-=iVBPdwjv0r3WtrYQhQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 7:04=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> > v2:
> > - rewrite the subject to describe the change
> > - resend with the correct patch content
>
> Please increment the version number when making these changes. Otherwise
> it can be quite confusing to everyone. I believe this is the third
> variant of your v2 on the mailing list.
>
> > - resend as a reply to v1
>
> That can also be a bit confusing as it will fold the email into existing
> conversations. You can instead link to the previous version from the
> changelogs.

Hi Paul,
Thanks for the note.

Will bump the version for the next revision and send it as a new thread.

Regards,
Sun Jian
