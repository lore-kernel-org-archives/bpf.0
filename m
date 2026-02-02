Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2A199252
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770003832; cv=pass; b=YOu8iSsGolmj8NjA2UepbfiS9D5rHyB1q2rk83ebBTHayPvviq5k2CBvg9sYxwPVMqmhBp4kmUocxGgYhdHAZBKOJT8jdfOPntUurJvoEsWfLOyhfqxM1htDY2LxOI9zeIJWR8WZKu57MPJkupXdjTC7wBOAGRJBZBwics+GPv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770003832; c=relaxed/simple;
	bh=glS8uDVkDR7mMFxtneMOU3m8N1JVB5ecq3MvWCrL388=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTnhXtAQgvlZAX8HT2p4cdokVQy/E7O9UQPv9/mSOeHzPX1ZJD8vzM1AAcJoQ8oyZHDGmOx0JqclhH9Udl9t8Qu+j14LLH27PUr9MrPGICejSWbaRLTudAuw+O1wMekoFiIi2Lr0QER2xZiQGxPnwL8Wriv3gKUDI3eajgCOF8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOdOP05/; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOdOP05/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso40448455e9.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 19:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770003829; cv=none;
        d=google.com; s=arc-20240605;
        b=kMVCOi2Sahj/HoRNsC7AE6AHkJlQSdPx9IuVmpb0Un/3sc/2DHuVeiGLmK1T+teBUH
         VqA87UpFR7sVv/pNbLq+4ifkoXbZ+ImK2q1uyFY+yXB/5XjTfTSVPdDHWQxkkorZAac7
         erEGsu3CFd2NRjrbuDQIRZu2hq/5vd91qh3ANRSWTjzEepqCRl0sO89Sm+hAUjTBdQrE
         KRgM9pG7NY+q878xkoTgzGOJTCRMOt5pF/f2EXDWP3Nog0Qc3PYvkYWk63RtSKsj2ZBI
         wbX6DY7WbEwa9pp5hzd5zSZMplyAJnTEeshCZ0tn5bHvjfosZhMmihwIYGhlqqnDwTFq
         jK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=glS8uDVkDR7mMFxtneMOU3m8N1JVB5ecq3MvWCrL388=;
        fh=RYIadHUR/6ewKj/JAAquLnNCVmQCllWc/SQeKfOGrgk=;
        b=LF077wlA3dd/rgCIE7U2okQO1AuUhTYHpbhd2w4SsgEIfJLS2F4MGnpy3abRI9SFM1
         4vS9w9GKQfrnQNY8DdpJa2l3o72Nkzq8OOwIFAT7Mg7gr8RLo4YgbjEgFjOn38JRUZjG
         nqvU43ltDfR9xTWpbpCCLtiwzdpMwG7xSL2H8ZrBD8MfIUSSF6Vil9ELtCRMB5a2IdCZ
         wFDzlz2eGA5AJ1gOe50N0wQAm3tlpVdKnlHaemyCMa6fH2yLcYGX3jVRPHPmCvSu3IDu
         iaXh/N/lRvgBDKupNe1hUtGJ2gk85d9JTbmGyxKK2Md9hfxaiEkIf5B7fk0L7VRrj8wl
         VfRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770003829; x=1770608629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glS8uDVkDR7mMFxtneMOU3m8N1JVB5ecq3MvWCrL388=;
        b=AOdOP05/iXIiI5/7JENFuml+yFU0qYmxJy3yi0+6h1nmmZZctERyVicAbKcBNXunu8
         uQHkC2JwHpz4v+TTY2zletPfMrw4nwH2TuFQllEeb3jGwZ0xrxegH/JGYincI0poajcs
         ZddUDEl6It7Sa8Ntt0ofWP1Iy8b1bhKQae0oTqNMyTb0ipmfl4aGWiu8NQRRHqM6EUou
         Xt8PEhZdgAIXVCJS/2oWEDlBgOavw0pTZtvmNvzbZqVCpkzAMZBd4E8Rvvu0JFQBGEw5
         PVQELctXU2rgUCAx8VPsw24Uwc7Kf1hBx/XL7EQ8ttpEKyKPo796hBB5eosMk4zAkIxB
         WMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770003829; x=1770608629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glS8uDVkDR7mMFxtneMOU3m8N1JVB5ecq3MvWCrL388=;
        b=WpgM9Hdgv+jZ/rgKIfCEkDsApgvZVrWfK2H0lyXmXLbeh7cUVI+SNvhMeOJI+N0d2r
         HWjLn2IOhnZfykwnK74gViF/jjrhOfSsc5iqs+Tm2qVmbkeg6TRMaMnx82PGcF5VNdT1
         Ko+UnQ+lCv6IN+Tk/itxtqp9swR7deCfWvWM82ZSnIYypRCUcaVPIEQBBxxlE5NgrVKZ
         1RnRbdQK1iBcO1cVBpCUCvx8bhjKhcMssLZqXIKhIr2RV/eJFy7CMtrfphUg1NesEe2G
         bmlhBTvcMihk8xG+uFe8B/0hSRmZESeYktIRuCu6tvAwyJtA41Byfya/rX6nJx9F7MKI
         cLag==
X-Gm-Message-State: AOJu0YympjdJZER55wJq1afMeBW8Z5K+oqRbRcJYFNYSPrcglzBIVQDN
	UxCCR4z9N6Fn9tDLRWBivv5ezLCeGiVXNVixj3CC47FCaKxJ2QLbCfdStNc0kqOIxLNZInqzuoM
	/kqCrd6QnyqX9kMGETU1DC6z/N4sarQA=
X-Gm-Gg: AZuq6aIijQyyQgJMt+8wnmcxbv2p9anQII8QMVVEDTYZFWDVTUWgqd0NRclCKbL4i6t
	PZfF7HLo/uMU2RGuOLbX/OjQ6+9NpQ7AheYj4MxoPqaUGVuNqEZDkMGAe4N8uJBiX1lGZdVEZZD
	zvBzijaGPYfjHRavuMoGee1Al2ySJqmAsBblGrOuXYUBCw9i8TO2JLBa7W+Z4qJaZOhWWb5vmRC
	rH2XLqG5tLVVLMSEQehQTSydSE6UavsRh4VWPSFknbv/1LE3VgXvZQXQkdOBCb7vx4sUSMo6eoA
	6vo7po79ZM1JAerWsY924fIODb7i0MLOUsLjZVJQdC4OWPrCWWJx5Li5rhrl1AsmdiUd2qST+Z4
	jYEmlvni4aaAHjg==
X-Received: by 2002:a05:6000:1885:b0:431:4c6:724d with SMTP id
 ffacd0b85a97d-435f3aaa77cmr16571275f8f.29.1770003829130; Sun, 01 Feb 2026
 19:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <165da891.6e03d.19c1c554d72.Coremail.kaiyanm@hust.edu.cn>
In-Reply-To: <165da891.6e03d.19c1c554d72.Coremail.kaiyanm@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Feb 2026 19:43:38 -0800
X-Gm-Features: AZwV_QgWHQqtWyM9D96-f0vEkE0tahhOzZpEQix0M5NB_Y48csRRtzIIxj0oFjw
Message-ID: <CAADnVQJVi+K1gx8PgWQtmtcphwgwHqT3mk2_TGuTiyu9kv=6Mw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in prog_array_map_clear_deferred
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 7:13=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <kaiyanm=
@hust.edu.cn> wrote:
>
> Our fuzzer discovered a task hung vulnerability in the BPF subsystem. The=
 crash can be trigger on bpf-next(39e9d5f63075f4d54e3b59b8238478c32af92755)=
.

...

> CPU: 0 UID: 0 PID: 9930 Comm: sshd Not tainted 6.17.0-g39e9d5f63075 #1 PR=
EEMPT(full)

Same bogus report. Not worth anyone's time.
