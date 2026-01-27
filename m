Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F12248B9
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539467; cv=none; b=ZhbtngdbRdj3alNfPMP9nRdnOBKhzHgLOHLKrnNZDfUvHhdxcSZv5MB9TUvJ96CBhqxK0e1smphto2OLP0AN+25/v+iY00WxjzlRwbOx59u1K98Suse9jNAGaabLATp39UlilhUp6+Vxmut2OTyB9/duHHkzVhC5gWrKXy6Pyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539467; c=relaxed/simple;
	bh=Puce/Y2uoOhkmXAnyMr90G2Ehk1ZPgymehgrzrUE1uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdRvp4QvHIqiX05EpBhRiC8Qelog8x1+XRbQeZH1jrsPannP/zF9btXXXPz6xSUYVVzzcMuJ161Djj3s9A70+dVs6hlhJy+lLvnBr1+eC0jISnxkR5I4n2z2mV4LoGgupYdvUoCSbPbT6x4jnHmnDjQVipW1n4Ht+L2MKwObu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Aqg/B/M8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Aqg/B/M8"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59de66fda55so5211834e87.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769539464; x=1770144264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=Aqg/B/M8xo/IziRc0ULFjlHqPkOIHnCQXTmylhOeeo+lGhU+VH2QEfmHV9J8Q/IVC3
         pWKUWRM47RZH4hz7cZK3hz/LkEq/+b4zEqdh6CqTI10ptZ5O0Z6KJ8wyy2niXK3QHikh
         PdDhq8R+9rUjfyKOF3phb6ebQLVeGVJAVl1b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539464; x=1770144264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=jOvV1CFd/Nphsffc8/VDF6K7bybti1F5xkBXG1/x7RI+9sSS+rxI2sYfGOrI/Eje73
         k8MnH94gqgZkEmkDA0HI3Vv3Z6AtkTyBojjTFnmKowNpM5pBX+OMW9n3uqCYNpGDQTE4
         cGbISlCWDrW6fQc0DyuBfic8zudXctoEeuez7KugY0EvjOgGAv2Tp+evVl6CmD4tbAVf
         OGPkdEXAeOdM5kuz0IznglGAOFiyGUM//LCeelM5i0OhbsudfIrsa0ita1RHRbwL4xyM
         XICSwG1Ny66nBe7V+Ytp33lhfbd3rRkFvh/AL0UNSnoHjo0MWBR/ODnojQ2tfV/rhJoV
         9zzg==
X-Forwarded-Encrypted: i=1; AJvYcCXSJGKL+fDOdK7Dx0GB56JZrmwYuZcMYTs81d+Rg6MCfxh562WKKCJ+OA+SB8bQ+lXxjZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztL0VeHdrYIcQhSXxQYpEoQ04+OfF7O/ZRtbpa0xyA+2H3iIcA
	ilb6Mkg74sg/3xRYEdj+ERAthbaQes/DnR8rBxRSg6KdyjzWXY06YUDZQ1GNqj3oHFHj85AreVS
	q5csW8Bk=
X-Gm-Gg: AZuq6aLyxbaPl7q8+30oWLBzVR7LFu28TPspOZMDES9U9HSVEZ7sPcK8Vw+zZm3c4f8
	IowMEAMvOg/ZWHPhJGaDmyAIC/Eh66z9pCljtOcAvl2bF+wQmoRpYeEI9eC1BYURY6tbHc0KeeO
	T7ltm4+XD2JJVwpfKfFKnOT9EhDS6p5yeuzyfcM0dAMtG6XVabGOeLClFGwRhr+mfhTwKLq+Gjh
	IfZ8BXofhy3iMQ8uF1hMiWfXCvtU9exphcTLrb+kI4C/KuAJFwwL+rRrKI0uhujDZeBj01ADh7n
	1wV2aVRUETm001OMaFMySuCTs95KkOvH2LD3Owvy4ML+GT0OAqHeaXZ+hiN8vpyZaadF+jHHtCK
	IJW8O+xq4cWjMocA7GxNmOXh6/ZqBEK6+lyMkvJUM/nwtXxtk59mH8kngp4lVdo2mwT6CB3cM8v
	UDciz6SItn69OVZWhGjwPwDoeFkwY7Tzi2CSKPcq0iq3RdUMYi9mrxCKvRRPxn
X-Received: by 2002:a05:6512:4003:b0:59d:f273:9cc7 with SMTP id 2adb3069b0e04-59e0402470bmr1101815e87.29.1769539464265;
        Tue, 27 Jan 2026 10:44:24 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bbf76sm91416e87.87.2026.01.27.10.44.23
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:44:24 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b6f267721so5700846e87.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:44:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdhNi5QjSRuBpxLLhsywbmxlOrfQEgegNgRJgui6OhcExVNIQ5tK5zvfZ1IpznGPan79I=@vger.kernel.org
X-Received: by 2002:a05:6402:27c6:b0:64b:9d9b:f0f7 with SMTP id
 4fb4d7f45d1cf-658a60c5513mr1939607a12.33.1769539160812; Tue, 27 Jan 2026
 10:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com> <2026012715-mantra-pope-9431@gregkh>
In-Reply-To: <2026012715-mantra-pope-9431@gregkh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Jan 2026 10:39:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
X-Gm-Features: AZwV_QjTvEFSmpHcnOP1NJLVZBe5xlcj-dD5ZtjcNC__rjqudIVF0E_rBxSpQA4
Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Samuel Wu <wusamuel@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Jan 2026 at 23:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note that I had to revert commit e5bf5ee26663 ("functionfs: fix the
> open/removal races") from the stable backports, as it was causing issues
> on the pixel devices it got backported to.  So perhaps look there?

Hmm. That commit is obviously still upstream, do we understand why it
caused problems in the backports?

                 Linus
