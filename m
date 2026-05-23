Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE14280309
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553557; cv=pass; b=YNK48KVxapQsoxajFDl0WvB8qGLVUtKWPkZLknymRxTGNNah+7sqMrUz12wcEsycUJWAkoMzX1SBsPXQMqs+YWG35hS9lVFQ4k0SL22YU09a1zv1lyHLA75PgbTXopAef7lB8aWrpxnEUOgby3/1ZYQPqOYZgFQd8pSfoemmwbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553557; c=relaxed/simple;
	bh=Ytx1TNVslP5G++K9RvHvRfsfI+CjjNPL/dw4D/mqN9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZxVye9j+E1ajzwZwS+gaJxT2KlXodt9rl7L0Cl8uzy64Y5EOq+8dIJYmkT4bDFSuyPpIjg5ZP/mM4Lj2h/3D5hgFlFqh3xWnjxPeYHkzD8eLOchcZTVREWH3rt3IZ4jb3j11vB8HVCjMKckeeB2xwD0J/UtxGqXljXiRP+fZd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q33XmCJt; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q33XmCJt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso3770665e9.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779553555; cv=none;
        d=google.com; s=arc-20240605;
        b=JsiOFyChv2VLH+CDGDifbrhYnd8zzm907u8bYpBGS6ga+q5f2E56SVwaYOhbPIviTi
         IJ722XkpJre/f/YjQQypBBQ9LJ58zK64zkhd6fDSJvlpbj+0IurCYxfBkRLY31+Ef3qz
         iKuwP64LRwbKoLDGw5XDbwIz8YLl4y28WH9/mEpg1E4Zr5iXgMBJHo12n/XWrA01+uO1
         kibmJrw8208Ec40QUoG+TYwv0ilRRH6TnGRjR1emxP6AVeKh13A68ouJwD+zd1fWkZZj
         lw7tuO0j+EmGPXkEvE+O2eTcO4U1CQNf5kJ77WjlQM6seO54IL9uqE2I7yiCkcKiL4dO
         ZF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqNQFHZHnntOXr5na+MhE8RV+67wpeGV8T7ZomckRps=;
        fh=n+CFhUxPc2M2/wbvXX8s5niLFzTAK2LP9rvtwhlHEkQ=;
        b=S/mb/9kma71ZTZTTZKZoEL7V6oeCceVg4EKqrgFZFpcXy7MkCY7QY1fphR4dOPt+km
         2FIj8t7ZEOIlAF9BdTWCybZSJQlWiqYaItVk2Y1vVFSty1V3Jdo6qPUYiWg5mqrBRrns
         P6/zUlvdvJOVigUaZFamWY+5cXyNvcR4fs41uaxPY8GZLkf0lWEBIYsdUsaMaSwSe2SO
         E9dL3WFpidIlhwfTyOXmc70Ld0SFjOLrjvKhWCBulBOtgfK/B5xYJnQCg61ggmGp/Y4K
         MZNgX0DBPmjX4xfLXtIDpWLXvQw0FFHd8o0NFiVclVFtNAlmYO6T/WOlgLkv7NaooyOm
         oxRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779553555; x=1780158355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqNQFHZHnntOXr5na+MhE8RV+67wpeGV8T7ZomckRps=;
        b=Q33XmCJtqaFjjo1hABj3BRBngSANBI3ext+cDn4p2+FLytrjguHEO/XoKFVvuSycRW
         NNGsJIkBQwbSyOFFymVaht6K6x1D/7iF6IzrCVG7t3sVPMOs/Kolm1QzFZk8phgFFyVO
         bn6ZjFB54cOQAIY37FUHOdGfWIGtR48aQuEAMvNPgvkGXgZcTYvX/ec+4pWTRI39RBuE
         Fm3r/jUPbGpr0N1LWFaZ7YDmyeTBkmXA82OdcK/QTKDlGuG/WVlzL/425XgTuPQokO98
         FOe36rTxQ2VH1bINUL7/5kxs1L1fypkYTpozXwul0cffp1J4i4Q6bauo/wLra55DWhp4
         bGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779553555; x=1780158355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqNQFHZHnntOXr5na+MhE8RV+67wpeGV8T7ZomckRps=;
        b=Zle5DEu2rIlAyJtP9Ft9P9LTg69tzD8wRvVSV28/DwnmdnDaOgSlTFPc3/LY8kJvKQ
         WxnJ97T8HcKvHWkJX/bd4xt+1qZk4NIwKxKQ53t5L3kCV6+Cl6nRczRVgt8w4tleA/p8
         Myn69d6Oxzr97w9az3xKV8myXm59MmFkMwjW/THSSbwQaMM+7YkIJ1GT+D4qtSHvJnW6
         VwnQSBK0g+E5/SBDb+sDsLLlhgL3QHT6WM1ujU+mXO1asEJfTywB1vyJfsbljoE0ozCU
         +ZayDEsWwhZG/LBjESjGGYnl+yJlwqIsT0cUj8wSZV6usmghcXa8ah0MlU4P/n1OpT5Y
         3xww==
X-Gm-Message-State: AOJu0YzK1e0vqFldjq1bKVBBsdIoOZPv9RzNHhuLJg9It5NRP9ILCQMg
	8/r/8+J5NlAmctjBWnlA0G67j24YnhSW6ZqEJzzdZ0CzBbALwfisMIU4YhlslpKHGbgQjbeZ5Tz
	FJiqxOsJQ4CJtRURbyEIBhW6CmSCP8/0=
X-Gm-Gg: Acq92OHiMKjAU3mpLoQq855+Rx/d7rm1ucj7lgKBc//ahZjZRPkqBWWxc2eLp/GPIlq
	0GCkBxxS8w/YnP+x5l6jYOgNNvoOK986ifRy/VjXqGViHPHOvGyewKGQQIudd65ZVKfDCrROANN
	BJt+9dbq2lfnoJnyBzu/tNgGFnLznOHW2q6COG3EwzeUzt4+I1iPL+6nn2XPYV6erGTOBuWjJif
	f5Y0AUpRmO9mTwMVkbQnPHdvz/rCbQzH7Ea/k53KCAy/LYlgydu8o87W9TDowC7CCHoxutEf0xG
	cqmJ4DVWVMK84MFiZzK3VJpzmboadHmRaS0pZinAhrn/wP1jQwMFYiyppJMpE8VV4heFOHVaeo0
	xuh8=
X-Received: by 2002:a05:600c:8b23:b0:48f:d5b2:7c1a with SMTP id
 5b1f17b1804b1-490425aa7a4mr127133315e9.13.1779553554536; Sat, 23 May 2026
 09:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com> <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
In-Reply-To: <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 18:25:43 +0200
X-Gm-Features: AVHnY4JK-uiOQRjTQpy3Cq0F5W7oehGBntUzRHm0OSVAMLxwRID9xE1SJoyyQqM
Message-ID: <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > If security_bpf_prog_load() fails there is no need to call into
> > security_bpf_prog_free() as the LSM will handle the cleanup of any part=
ial
> > LSM state before returning to the caller with an error.  Thankfully thi=
s
> > isn't an issue with any of the existing code as the LSMs which currentl=
y
> > provide BPF hook callback implementations don't allocate any internal
> > state, but this is something we want to fix for potential future users.
> >
> > Cc: bpf@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  kernel/bpf/syscall.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Alexei, I'm assuming you would prefer to take this via the BPF tree?

Paul, I see that you're intentionally trying to piss me off.
It's not going to work :)
