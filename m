Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED2248423E
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074924; cv=pass; b=jCpUxQ7sy0W2+T8hS3/EwgzWcpDQqvKm6S4DLaNkIaS7YLHEJSYX9h2QOjYr+82LUhuCwl09DKoBTbse4W9fAYR6chD1YVB61Qkx6gfF2xx9qzjgIkTJScMYqj97p+NbZzwF/Ddc//He6d/00QekhXwWNfjzIwOb28/BNklPOlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074924; c=relaxed/simple;
	bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OP+vKSB5acY/Z4xyCD7RG1Br10or8QOpNyIpmwtvjYgbV9l3jF6i+DsLbxygk1+4Pe6fXASGcZsUjfXdia/0XAZVVUUPGw5oLNxK8RwVLmJJ6Mv2CwUlPLvlN2cF0Hn6t2qIB5vOkWlwjcnMC1pYMKyJnSkf92uzgdAWyPKiLyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVgCyOLy; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVgCyOLy"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8edda5d56a5so2207126d6.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 10:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787074920; cv=none;
        d=google.com; s=arc-20260327;
        b=EuOmrrpVQjn1fT4MAsSJy7Uu/QcrONAlabCOt8Of7y/CQPvJEo80mE4/9F+cIvJ/YF
         qXcCVmjoqViNniqgc2Bwt/YRtUO880CVRiknJnAXlOqzgYGtL/sHVzxBwsGqPppXGft6
         1h4GbL1mJUNll/TojiUdOsOv8Qbr3rRrxmqkORPzlWPl76M0nXKbNh84OnPLKS87qO/Y
         6xTIDAsa3C2b8WTPiM89kOC5eM+Dov3L0I01250sMqFhjeTNJlxXbhEamb8d61elZcQ9
         jmSWUDlqNMQzVRpIZ4pXBYTUdaMNw8Uiea0ASG/7pPIRcsmWWVV7ri7zVWTlqIka86Ct
         H+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
        fh=u3fUbNgmHYCK1caWA4i97Ado6MJSWPI88BeUf56WFLQ=;
        b=OZ1HKEdz4kRyQjpEpnKXlgb5DbOhYi5OnnpeNZ1olnf17nFiTS6H1GFNsAbqr9NQMh
         3IMpOO1VVkzpENUd6Zh+L8MAchSOBm/XSdrlMR1FWcKzER40JyxkTkfqMKFkC4xQxgky
         GlBRGK69LhFrRnVku9u0fEiPCxKoNbt7SxC7JE0THCFFW1DR9S9QUsxxsQ8ikIy9+sq5
         oib2OzJPadrXg5CmpTHSYuifF5ExmknjN1suclTM1B2GitVI+2QVhmK+wp8PLsnuZgCS
         3BK8X686BAmXlo/PQd9KvmUQWEuxUA7K6U+37F3BqPI/UADcun90aRYZN7C2v6rHjLfk
         vNZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787074920; x=1787679720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
        b=QVgCyOLyuehuQgFYAb4QVdKb1IbW4B45cUA+Vk+6lmNzR4uDW6tNHYcZH77qh+GVyt
         IjwNBMwbq/5D5T2MLHAqUcqC4xbmIYgr+dmrfUwQInp3Ii7c4KDUwP7F+eC9eg3Utz9h
         GKT/3qkjvwJVnPDjgpe2dusIN7N/bwlZY/LubM7eZ0TTzLve1Lgggtr+ql62WI2ZRTXy
         RPTp0hMYbhBrBG0c7Z+s90xAwJ1gz4/edcYrHI6TzRFYCu2AUTy/JQt6cZuPZY29F2v2
         i84AUCk/NWwDkpL6ZrNp6THAtNeCuglTWtpYSMihlQWN9Y7EUQ+XpYtvosCV5UJlQdrx
         G7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787074920; x=1787679720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7koRXVLA3oYazNCeGdonu2Fx0u9xqB25POt9oeKXmBc=;
        b=LQJRWbY37nf2llghsWdANRN1aVmFUEIJid8zZKra7LUEuIlDKQrLWePMrEBFevdpjZ
         FKkw8OJAAyTYi7TjKbZb+WtIGUyoJwpy7VQ8U4uiOH0RJpjxkfpus3Rj+rgObTflzjLK
         rRgzXFhPpnhP2GQnMrB2fS/5TBS7BcZvtttbl/ZDwIYH6857y0h9HBbngCHS2Afq81+o
         1i1pQTZ0D6iDuIR4S7klSjDiT1HwDoH6mXzEkpRspNxlL6VRq1XvTXlMsrUF6eZg/Us6
         H69Rfmr92ga8jCQgUyF4V45mOCQLQuu9TSwtRcayBlrUvkzzSSuCTgARL3+LVF4oCanj
         1ekQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrkm3NKoGslrwL+MGM3aMWlz3uhNNt7+TqzwgKTIiJyrzo49T8DnhK/z4M/ult/uUtfpCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAdi1SQwNCaTaT6MecKDHlDMrUZpCde1zzKncSmqBlowPdK08p
	NiClmazGdZaOakwe7rhPNRKZxLOW2pubUBDrxg9GdzTRE33JXnHPzWPLRZ0dIm8vV5YtilWvwjn
	WGAGDdZf+DHZpvt2vLxRNBwLr+xfYln0=
X-Gm-Gg: AR+sD13PfI5UJacjsvESMmU20TfyF/oGCjMeDEsZJf2rLGFCBWc5P8LPdx0QtOnq5Se
	VVBRybBYtbol0/xJqHeP13fOmDQejvohPyBIxnF5cv5eJoKlfp0zvMHT7HZ1+LkhSIf9IDVyNHK
	kSO46PvyYMwo0y2ciUV4VobmZ3/g9UpJIQCjdPf+Clb80sTVgqynm65dw1TUzKLb+uQbiHONvmy
	T6CGCTI6LmGH8M7OeZOz8hrFdcxYO6V025yQMt9cQIXaa19sanQF2LflSNrUVTsLp0h5EazPjax
	//SspchWR4b//luY/2Z41K/44QaB69HFmIWOjpPT0qbBWrv/NX7iEv9OJhj5LEguDyp3UtbA+QM
	=
X-Received: by 2002:a05:6214:2607:b0:907:88ec:6002 with SMTP id
 6a1803df08f44-90a91d23fc6mr359439716d6.12.1787074920246; Tue, 18 Aug 2026
 10:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com> <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
In-Reply-To: <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 18 Aug 2026 13:41:48 -0400
X-Gm-Features: AcwNN1XLdyaSasMTp9iBpNvyrMss7F-pcwuEvUrbotoGcvR6ijlcZVek2kfbZ2k
Message-ID: <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
>
> Lastly, given the difficulties we've faced from the LSM maintainers, I'm =
not
> inclined to waste more time in explaining again why this cannot go under
> security/.
>

I'm still going to send v7 of bpf_init_inode_xattr series, even though
it's a stalemate. Haven't yet decided where it'll live in v7, I'm
inclined to leave it where it was (in fs/) since one side will NAK it
wherever it lives. We can record NAKs and take it from there.

Just wanted to state this for least surprise when v7 does come out,
which will be soon.

Thanks,
David
