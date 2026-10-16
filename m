Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF535C6BB
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163269; cv=pass; b=UO36quFKwvjDeMoDqR9mRGUuQO+zuS5GWfxLk5GH0c/QKAfZCaAstNDM6WtDE2xjWvm5SFisPb0ihfIIaro87+Xx89+IhK3CA4VVfzrJP9qWvC4yIeXQXf5S2EVnuqd4CTLjz8N21uKDvc4U0xZ7FVCZ4PyuKC5CCTPw5piGvpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163269; c=relaxed/simple;
	bh=Jz7OPG5i1YNe6jS+9d/SCMY2DWmjP5AiPPiQBLjiYME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLHQo52v38GSrHzXRDBL44gttSCV/ig+E4LoAq9kahQxcWcpdXqAs7F/5lsUcgGGdPIp5DYpgj+ci/kjRqv4g0tiqBFr0qFYMjFdvxWFXaY47qxZgVqbjvL4WYwO/TGheW7I+L/USd+enxakxdRrDmQr12nUsI40J5dBug+ItnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rXiyiJoB; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXiyiJoB"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f20b304c0so3676485a.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 08:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792163267; cv=none;
        d=google.com; s=arc-20260327;
        b=P2SJgiksUX2mHzzSl6hKfLZdvBc87ihfFXQ/EZKvVmalo/NeFp1sFBQnOUIdCi5GZH
         YwbhahLq1xd6lQIgQoQgnDZi/sFJhGiHaArcwQf6+Xa+nJJN0FJ3RO/7NnT0rZ6ro4Zr
         62R64qywggWJo+UVoMd+T4YxYwVV4a5c5Vm5lNfMP/HGyZQut8AxEmad8VQ0uoewRQ8e
         tibKnwdM/DBfU/kMUI8EObVLR2VDjFhD3MJmmr/Xm7+B4I3m5pYh/pkXBTvXCvr+6LVi
         GdO+lYVmH4ELUPYLtGp0YjKu7akQTcs5fqD6/iehdUdA7z6cgCYv1rU9PgI1DAFHoeOt
         iqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jz7OPG5i1YNe6jS+9d/SCMY2DWmjP5AiPPiQBLjiYME=;
        fh=MGsWzWN8s3m9ikv4Y6t15VLjZdtfg1CoyJOBaM+CVtk=;
        b=XFGdHXJT58Eug8kTpXErCCjJb58FDa96v+dB/WLpixGii9Me8Vh1dclPCK98bu3SfT
         8YGNeRCC1r+KTc7KjD/TTl+HdGBTJOCie/tTpHgvV18wGa/aSfrgsl/I3cPJ3p8CPK27
         FqWz8QujpPj9VGweQ3/aQBqxx+MStxmZLAOZUXN9ykAVtnPveo35V7pnob4IuAsvcYSz
         jrfiB8bk5OP235SCEWZPuzZbqwr4sc+zfSQVqN3UGETzMQRQw4fhn8SGCHcHnl7As6FH
         EeL0bzCILoj/NuRywutH0AumHDZDPoBuBmd6j2uc0EhPNksGqP9V9XtYOD+o2pGnIvXq
         CWrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792163267; x=1792768067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jz7OPG5i1YNe6jS+9d/SCMY2DWmjP5AiPPiQBLjiYME=;
        b=rXiyiJoB5ocTFuYpe8OLi8I2Mk1+b7vs4O2TfEbI/Yu7sceWdliX8feW4A6s579Es6
         38DmYRZsNAFj4eFiakFA2X1C6mkOvOYXDnNrrIo7a/H0JLlcrfPbYJ5L4+K1JoJ3K0+D
         97aRBhB8Ny5hLJPzg7W5OlITzEInP9qyQ8Xn/YdUIj7x2Si5gnP+xlILTwRCJSl5ZdGs
         UhmPuCTJQdJdUMRxyhuxvnHn9Ruk3+aGbICXBnj4hi8mF38YG4Q+TFyKqCO6qAje01FS
         nWHxaW60TgIepzSvyFZKhHEgBIYtBkpzVmO/dDJ3CGfA9E0rwEst+c1o5AYRU91UgZfB
         PrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163267; x=1792768067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jz7OPG5i1YNe6jS+9d/SCMY2DWmjP5AiPPiQBLjiYME=;
        b=Ik5z1OJW0VrV1PlQeVAz8RSDvKD0r3io4S/dwye/PQBeOgmvy3p9V0Vu8DrOgrwLfa
         KMkxPpWBuvIaNKtBmlInLha5dP1/58gzA7zaSOn579LMZjLbmoec9ZjoFv5FCj/b6/eq
         ODDD7Hz1kW4VA5DbURi0n6GubcLUim6drbw1Py7TttUrKIMnBDXYCEDNZusNqX+Il41W
         BVl4nUW2LFv5hZu2+lenSQW5hyD7rLWZP6+cYngUvnqKvqVzQqZUCNyakzHOvxWqhZK1
         /9BsiKQYTldARYqOmd/FlHqYZ7Jlt1jVSwMB7XFgEsfn+LCDL42wV2I6vfoS9OnFQQm6
         HqKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEn5o5p7p3fkwozUcCGOOM/cPq7sMvbMhV7iWFY0hka6GelxZW6VBy3iBkLvNfeG8Ut/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfVEWvUMFdmxJYgjTwhfvfF16ubn0toJw6heY5DxFpCUwDTIHR
	AKRZk6XZ3s72/JDc9cPm60tscRQNAUxdbwpt62ouocqiZoQtzDqjz0nW5UDBhLBwLx2TxXqAob8
	TXlQFm0Vu0Bg75580sCXrc8kbyoFTBaA=
X-Gm-Gg: AYBFou1KboUAFTzfgrtrQjjUSGsl2YIUJf5Vel9GG6qWi2vMllnyNAm3Ciiw7er+UBU
	BVy5KXU4XXbmbJ2c5X6P1NXRKomxEqshWEuPKu/sR2rv+/iOiCeqAE3B8IdWoc4qdqvj+DEavGh
	Gs+caFa6aRWGDxuiwRqvAMbIudzxf2OoBWVy4QOxchP7/gXWCAGZkp1qErfaLefml2VGCtpsfeQ
	TP5UYfM0gJbnbvxlwI/QbW4Z9JH8FSnWM+S2vLaBNxS3+YTyhCC/hrKEzLdU0g4LuWZ5X/ubYIU
	bjTGIRANbcdBimRN4He/YnkhkZWmV+t9G7uQR4zxKRYghgna48LUTgyauFjLb8DBqgF9KCeT5fJ
	wEZQ6danlDw==
X-Received: by 2002:a05:620a:2811:b0:93f:27b4:c441 with SMTP id
 af79cd13be357-93f29da8b67mr17336985a.65.1792163267372; Fri, 16 Oct 2026
 08:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014233442.8392-2-emil@etsalapatis.com> <7d5f77a9d307bc2cc1ae43aa3cf628757e2342a26b02ddc9daa0276ff2d6c094@mail.kernel.org>
In-Reply-To: <7d5f77a9d307bc2cc1ae43aa3cf628757e2342a26b02ddc9daa0276ff2d6c094@mail.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 16 Oct 2026 11:07:36 -0400
X-Gm-Features: AclHuK-rZTeXvuzyphuHGnEUpgBWSHr78n3959Bd3muvbqGE2hkNWTgHfa8JjCo
Message-ID: <CAEXv5_j=KxJ4gadwN1WELAEuOqC58_RSHg3OO8D2UrrkxakqDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Use mapping tree to zap arena VMAs
To: bot+bpf-ci@kernel.org
Cc: emil@etsalapatis.com, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, daniel@iogearbox.net, 
	martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 8:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Use mapping tree to zap arena VMAs
>
> TL;DR: Per-arena anon inode is no longer S_PRIVATE, so under SELinux aren=
a
> creation, mmap and fd passing may now be denied for existing policies. Wa=
s
> this intended? Commit message doesn't mention it.
>

Do not let SELinux stop you from merging this. SELinux object models
have had to be updated before, they can be updated in this case as
well.

SELinux protection for BPF is essentially broken at this point anyway
due to the fact that struct bpf_link doesn't have a security blob and
it's unlikely to be merged anytime soon due to bad relations between
the two communities.
