Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843412DA76C
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546870; cv=pass; b=saP7C2ZDoeVXetVRT9jZuhaOyGFicCLe+Ge2IwYiW9sOUigT1/oGVHWmeqSod+pKtatCV/A2veGOVxr2HE8jt4j+yKLlu3BWK4HJscXLCGfzjpEjiIc1Vw6ms9PnSuZOI6G4g4SeSC3v4l+p9x+nac7jt2F4iNUloxOfaSZ1G6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546870; c=relaxed/simple;
	bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5mEkS4D3GNzVgCQU4n9VfAELuNIUaWD/AewMLsu6cTz/RaDVX2KjRMS2vppe7xVv5LHSuvs9/zM8e561Gdvps5fwyB9RRygGrb7TefnHk87UEkIfwcrofyL8WQavFbCUWGYgsihfxqZrBOjp3mOMkjiTXKl98aiFRFiZlXCzpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYX8bT8E; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYX8bT8E"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49041e84237so14962565e9.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 07:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779546867; cv=none;
        d=google.com; s=arc-20240605;
        b=OX3oJZdGNWGXhqRGTOKe5b1ipl5MuU50I/qq10HHuihDrBQ7TPOvBzx0U6/iaFqY0S
         cAnjyLLY4CB8C1uoGft3RAR3TWzyojxVy0hVSpEH6cLW7bfj0mwJCnRvAf/nhPJ37C6Y
         zGrgFWmjY4EY/WneWYlDVKQgFjgVbmhn+xEXpqpETyhNdUvKIo1cjO5KpMA3zcjhye4A
         f65d+U7Kvj44fOQsn9rVnZsYneFxPpryPawTIglik839jvYj87MTJ3rBUvBH6C3tciHC
         dsLB3j6XQnT7txB7c617tJa6uHTwyE4JUiONgUr+ERlV6a8A2hnE2HiM2/XvjkkXTisQ
         JhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
        fh=WbthHy4BSNvNHi1fflz82J552uU0GvA1WY3WuC5Pd7c=;
        b=LsMPw68jvgvUqga3UmLsLMntW/vMYPkNI0rhShfN8gyR7tYID3vHW1jFhOB4SJ1eG9
         qUnahAf8BygtM2og9+WrwkOzSsNrFeLVB4pJmWEeoEaUxhvKhmKTd5oCWxLjo4L/JUfm
         PrWadrunKrL1B/DG1BWgNbs03WWB0jZl3o/F4KwlV/GTefc10g+blpaEImZ/y/9zaeB4
         5EWGopf304RBZ2yTj7uB0eIADPKa8hL3OwtNXbT9PqTHoZ/KKbQ8vhLM0ICcypfgxN02
         mQmJnX/o8h9C4olYGuZRFKyll+owJGWsxqhFlQNVKur+wIhrH/P++6W0vvhjRmHfVXAl
         zXzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779546867; x=1780151667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
        b=kYX8bT8EH3Vnb539+DiExAqq0nzoZUViOafrv062kmy1OxnHRDzdyC/k5AvFANTYj2
         XzkQnJ1hVFv26mH7HaseZzrDhLPr9z56fH+HVWiuaO/6oqHkRjiCyihVB78CgPZZLfa6
         0lCiiBMLyQKEg8F5i3hOOIzFyFGZjSgBq5OM1ihcc/QK6N8EjI1AEtmSUoI2MMOn7TzT
         jiiyAoJFbalmlwdOqm6ZaRIJd7ndsu6vybe1ExcjbGqgluoINsmB04c+R0PtIUrFRZ1j
         1KKxYYl7JGcV4NYNY1MkyyihXaCsk1KHaqwDAgeGcpDlexRiasmchdzW1oj6TnssJrva
         PcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546867; x=1780151667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
        b=TSmceu9aaD4p98DfrCjWpvmNWXsgWzZmv8EHLcF6h0jkBYiO3Yo6+gpZnO9UNxfN4q
         yNsgkWGKxjhr7o/9YgiYs5XV941E8xgPc2Q97kVQ5bqyyF7DHCMBFz3wFbLmRYWzq1uR
         c3nhaqbZvFUcoHmmMrWcRms7zDbJqaMKvOs8DhxbzkHRBF+YWl+d0hALRHRypaDI/LTd
         TkGm4Fh0usCAM4cv7DRkPFVaiUYkJC1WlkqUboN0i4TZKvMGqKmiHmtZrBZdbw1f73R4
         P/YUZn+PPV53Uoz2bajR1mSY3/aVdDJ0P4lYTSUhkSO9ryD881BQdle5h3f87eDlBnUK
         +OtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iDT9em2Ehei/9I662didUVfb2iwEJXEVec2YtR1Ji7lX66DOhRDcUkxGBfnwxS8VYZWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmc4UiSmL2bOociWRsFnkLNJnNUZPcV9r2F4rEQcO1iQ5mwzvQ
	1DVyA/Ru72RfhcdnEY83rO8hpMf0qRTlHcjd9Qi2UBjsmfuhB4MLiuLB5YRJHOp09cJS4NIyji9
	wb3+bEM6VXbkRU1PQrgYBmOB6BdJC7/Q=
X-Gm-Gg: Acq92OFL1VLCxMBvaNrwWrm+84Wg3NQM9IwkweXuzBfjDtaJaUitygB4pLhxLx7H1M8
	U9ZY6FKlOExUAy4wTNgiJZV6NX2pSbqOlfaaZngqDgwZIeINqgD+NaMhoq/DiuZ0S56BwJkLGmL
	QzhVL9C6rGC3h5XfA4LEpd4alJH0LEyTpPV5b2KrCKqxRlcJOr6qtfGL7rgb2VuZ/gJOog1lHQR
	x8MBOl/wshXheznUQocAp4wBbKDqLUltyT9XOZ6V1Q+25XBLC/sPnT3UHuOTRwGDxtu7EOVp1j5
	jXETxqWJW5C8lNE3RqL6uB7+1wTnBtQFRYsNreqSCgBPOyYPTsNl8jB2pqAN8I/9YJLrXhKOy9d
	LOB8=
X-Received: by 2002:a05:600d:6443:20b0:490:548f:6ca0 with SMTP id
 5b1f17b1804b1-490548f6dc2mr14333455e9.8.1779546866581; Sat, 23 May 2026
 07:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com> <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 16:34:15 +0200
X-Gm-Features: AVHnY4IC-tTMKFx_0wpiYAXbGHoriQblp2jY3sf1fSSlKaxC5pprAVRKEGtp9pU
Message-ID: <CAADnVQ+Kx1YikuzMDt8Zv+tGXYUvgDuah9P-f5a=VBpnYb1K5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 23, 2026 3:40:46 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri, May 22, 2026 at 8:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
> >> the TOCTOU that Alexei identified.
> >
> > It wasn't addressed. You simply ignored my feedback.
>
> Blaise most certainly did update his patches based on your feedback.
> Perhaps there were multiple issues that weren't communicated well?
>
> > sashiko spotted it too.
> > All other sashiko bugs were ignored as well.
>
> Link? I didn't see any feedback from sashiko feedback on list and to the
> best of my knowledge it hasn't been enabled for LSM patches.

Check your emails. sashiko replied multiple times to all
of Blaise's versions and found lots of issues.
