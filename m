Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132562E7BD3
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085712; cv=pass; b=hDIHAJSbmQVACsnflt6jC9WHs+SbH3DLCNe0tiz4Zyb7yCDIYh3szCzQUAM+qexqX8Jh9UxN53BgXD3mp3n3xaexgbMm1IYz9W+7ekIp1e1izPm4NLF0SQICE7oqMBOrBfySZuG41Xt0NC1xYCs+s4GWSvQc2g8w0FI/pVY/I6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085712; c=relaxed/simple;
	bh=oSxvmMJWKPDVnxWkodLeetjh1ap0IaHpc44VwhS767k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM3FBEAodTlBheJvY4BdIXI9YqzV2UNfnYfpJuyWoc7hQYJX6DIDrXR+1fBj6xfjkV5jDOYlxeIA1sjAetuqzcR4GWfxnmGbvPn7a0B8WPaGQQm6zDNeVqYkcv1xwZQooIJNHkr3fBxipmEfadYBcbFW7M/AMVTTV8f5mTsCmJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxmz33Ay; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxmz33Ay"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso2959666d6.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787085710; cv=none;
        d=google.com; s=arc-20260327;
        b=nE3wwiMj6m/2Al4MCIcL6m4I/ukCpGss4L7gji4ahLszIFOKmQt5iqDvU7G84gHbkr
         MH1nQZBumOgwioxMUgwyFnDyOIfK5wHZQfyaifC+iivj0pwHzc2GJ01WkGotRZoOxMOf
         QJrc/lHmc+jOL0iNOfdE0dlmhOSqz7wuRfBZKuJkFOs7CdI/74gkHxf+qatE7WP0273Z
         rIg+Qh27yE1t9vbn22v94YFUcC4B1EmWKwT3laG4st4RF6CHrAyvqBBhMxEtWNsylxRO
         /jEfUIJpae/E0/ogP7FG4v3S5Gu9QVJYSSIU7TGIO+AwMozny51CModk5QmdfoEBOeL1
         Ik3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e+jRDvtK8PMuPCS2sGNAScxlW3qwdUi8K3HelhQRKVI=;
        fh=Q9DJKAkTv1znKQ1kjQ1neKDJVxNjJaLf5Q/38aQHdLM=;
        b=FXrDhQcmVf3j0ZnqjvdEWarUoFtdgA8vWCJ0g9nN6pfgeNh/FlOZTxLPFtPE3y96uo
         bTr6nC9hAVbptVClUTZYCZMSXNTw9QvSNkzskd702lAQZj7l3pHDFthNf6C2mtGrJyHZ
         G3iTkOh8Ldwmx8vIjETSJ25bPVl5Rn9cBZrcJmETkCDSbVNPOvN5T3mQTmL3ovEj9tbe
         YUevTwsaLJM/1IqghBzI6Q6O2CxJKEJEkqOu3abkrcBtFFZnebLit+WVJMMU7Z9VOEqc
         Kyl/yqeKjfhPYRaV2QpH8/zY5sGvVFYbybtAgzbNadC/n3XrdqWtBvy7GFpgD949ZpyB
         ieKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787085710; x=1787690510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e+jRDvtK8PMuPCS2sGNAScxlW3qwdUi8K3HelhQRKVI=;
        b=Pxmz33AyB8CrJNhyeFojiJvOMV2qlCaBwtyZnL1rCAvu+vnpfexaDbGAyHHwxZjLsz
         Dm5oyp71L0jbPAhkoiEZuhtKrx91IXQpW9pQx22ZDeLotfiFC5FlF/lt0KM3BXA8fZe2
         eoD/iGXlptYhCB3uKiSOSDpJNsUSKXxYR85eVeA8JWSckvyuSbRo3wHcPGc4BRJa0thu
         pPx2KYoo7uwC3jWAXZskKcg15Bl/P/k8JghBqiXgZR3JDf3Q9kNPomFJT46Jy9S3e0JX
         VpH1qnfRnVLUUR4cpu1oIQdkAcbsjStqKYnKgFageSmE0v8VVoSSgDmbivWquxwDKa67
         08XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085710; x=1787690510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+jRDvtK8PMuPCS2sGNAScxlW3qwdUi8K3HelhQRKVI=;
        b=jU4ZuNpoWyFt5QaLDUZFmP2JTS2PKT3jbygIHDDbo6zlQfaNYg+BSIhlau7J43HLk9
         NqF9k4/jo5nvOYqrRU9LPn5WRYOIhDCZyxLCb79QyH7IW1TKGNNktG3eRs3fK1ZmXGhM
         e+whatopi1vhaDIuaTUO5CmDNOByOQzD0nk6lahnE3p92Fic57VddsLq8T6dP7YmnmQz
         I5JstPj6RR2RXzjOT33JWAOue1JBqgGhX0fKm8GEZSyjuDAdaZ53yhIgxup97rcdzv6a
         lgDLXiLMM3Hy+5mRyG9TNP19C/ZlbFNEpo1O54WRM92KAe9PV9/QILT5sxGqZqb3YEEP
         44ig==
X-Forwarded-Encrypted: i=1; AHgh+RpIZdf1YViR16rGiVZXvWrNCMxeyMlLdq+uWRZjs0OajAvoljtt1BNVagDM84HuF+ssor8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hQ2lcju6gf1/9V7qFKJZSfHOovwVhStxe3DwDfOOM95gTXuk
	O9phyhfsSU+IUW83DL9lCRBawdEk/07X8+HwykuFEgmdCqtB9upBT7HKXJbKsqY8wBY6dxl8cCG
	OrkY5nZSbH9UZI5zlqPQbuq476geLOcE=
X-Gm-Gg: AR+sD10k9h3SDwjeP75zvXoPLr/5dRKOCjqpc9VNKK9I2ZFYaiWqij+ZVkgudImvmek
	jBKHY4AyvwwF8suUUKvAcmLbYUOkNHl+RZGAlH7dRlzAijFojeJ7lrp0mYod+G0jn983nkz2He0
	8SQc/0wyHLbOLUrgr2yOJz/L6MWELliPlMRf3hLheM46npFmhip1xz7VDnlMQX9lF4zLd154xfB
	jakzVVjQbqJHe9fmzWTPZ/nA/70euGhvpzsZyi53okbzmMMT6o/uOTIOKXCD2WmH8Dzm1x9hGl8
	Uq+pRz13Xfnp1yYGWCv1pYeNwguDUzv1nd0R9tVuJr/KGjZfy2SpcBaAdjkrtK0OvH1fUFr+PfU
	=
X-Received: by 2002:a05:6214:458f:b0:90c:5947:7e60 with SMTP id
 6a1803df08f44-90c5c24abbfmr15219616d6.4.1787085710038; Tue, 18 Aug 2026
 13:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
 <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
 <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com> <CAHC9VhRzfOR4-RtPapOC4am8F=sC54VDzr7hAn2UMxNQwp_38A@mail.gmail.com>
In-Reply-To: <CAHC9VhRzfOR4-RtPapOC4am8F=sC54VDzr7hAn2UMxNQwp_38A@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 18 Aug 2026 16:41:38 -0400
X-Gm-Features: AcwNN1VAkYgsCnapUQ6Evh5Gxdzz2qYTdWEeHRtYokO6ZmlzYQiklEHul7sqqh8
Message-ID: <CAEXv5_imtiRdkmGrdmhAk7c7SS65o_Lxse4+=XaTFYar8uvBtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Paul Moore <paul@paul-moore.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 18, 2026 at 4:16=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail=
.com> wrote:
> > > > On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > >
> > > > > Lastly, given the difficulties we've faced from the LSM maintaine=
rs, I'm not
> > > > > inclined to waste more time in explaining again why this cannot g=
o under
> > > > > security/.
> > > > >
> > > >
> > > > I'm still going to send v7 of bpf_init_inode_xattr series, even tho=
ugh
> > > > it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> > > > inclined to leave it where it was (in fs/) since one side will NAK =
it
> > > > wherever it lives. We can record NAKs and take it from there.
> > >
> > > As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
> > > in security/bpf_lsm_kfuncs.c.
> >
> > Hmm, even if it lands in security/ you'd not ACK it?
>
> Bah, a typo on my part, my apologies!  What I had meant to say was
> that I'm not going to ACK any of the LSM changes with the kfunc *not*
> in security/bpf_lsm_kfuncs.c.  Sorry for the confusion.
>

Makes sense, thanks. I'll send it in the next week most likely.
