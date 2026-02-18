Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B972631
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376203; cv=pass; b=AFibYmuxNEGB6CqRza5qlINKWItl25U1OVFb4DkcpxW+0gMaMkL/i/+96VUpwke5R9dQ43lP3jZDhRSJywtXBWzyQDzpgamahP+0hnsJKEQMa9hcEs662i0uTar8xTcFGh2GhVdk8wHPROLybV1lNcsEqB12teRMgc7wpObq7HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376203; c=relaxed/simple;
	bh=EBiLc+HIphpolHu94PLKkkc7XOK2BREB30WnqZUZ20w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d84tKF6hBoQfraelGT1TOcb1OpvR6XEq279dLEC/lCgkdy85Fu+mZmWpgKQqYWS2qAhyVHRin8ZKCaX9y3d0k4lnJW7xwxhrtzQpTjukcpov08dUOwjJlebt7rqkVS03k95v+W6D6N330IzDKrhoHz00aRjf8J5jlSLqUU+B3jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8uJLU5S; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8uJLU5S"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43638a33157so4592804f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 16:56:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771376200; cv=none;
        d=google.com; s=arc-20240605;
        b=cegpKUK/Rl6zPjrsPb3Gh18l6PW1y7hech2YZ0PqLTbbik2dXfvMKO8a4V3pWzahnQ
         KTEtLND830Vasa49NlLqFEenVvcACR1LZxN+UQQLgMXRp5FeiuuWTek9FZ5dFNRq/1Gv
         iZGqmifuzn5JwLPKJWtE9hyZ+HkIXwQfnOECaovKO0iQR335bSyMYpa75mg4YFiJBk+v
         pWttUZgH5oSShHgxYwduFADfxhdKTEFXjcD0HX4EIs4pOWB1+Z5/mzYJgGR838Pzl5Sd
         1OpivNrYmgfxUJP2PusHupP+nznJubQJWsZhATTGSh+5P9b+CZLCoiaFzVruov4uE+WU
         QZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EBiLc+HIphpolHu94PLKkkc7XOK2BREB30WnqZUZ20w=;
        fh=TdjkP3d222JlliJVytO1CXhSwFVzjCIXMeuBZP67620=;
        b=Xkn2NYO7obZ82u0A56yaKfStrZcSL9YpkKv4TMZ3+mu/lExNAEZsNISXmb1+W1FS2i
         THjqGEuFZiQbARHxW4pN7bKU8XBtMufaAlxF9oHpiY5WMaRT1IHIjZiHLLQMsxrNjkx4
         IoyO5vrwqOuu/pyY5JGCiD3uDx5gWVAX3rhBg0okbzHCbdyrk6hgYb7x7XFlr9Je18TK
         /O6p8iBZIRQkrLO3Bu8x20D3GLRZyxFJLMeYf0a0TPCjsCK598eOo98pb+5KLGTFEKGS
         JrgoLpp9Dn/eaYPR0xR+7gTTegXxyDH/LloRF8SE0SVoF1ceVD452l6hYpXcgk7vUic7
         +l1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771376200; x=1771981000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBiLc+HIphpolHu94PLKkkc7XOK2BREB30WnqZUZ20w=;
        b=P8uJLU5SLqnCHQREYJnOZ79iuazDleH9SJ5lM8YNXH6pw8QXAG2ll4EKFSIjhbY2M/
         3xUweWyZokq7X0rzj7lzyL/zF9S9DbqGSptJntav7W9a0OCV8ustczThBOLbxz4SO7Yv
         L+itJ9oeq4sbwjK2ErNMR6xQqy6bq8PD42WOvAtO+oakQJssfv25oszD4Q1HEZrzNEi0
         Bf0HCca7SfxYUyBgYWeVVn4CZNFz2M7AgAzuJxX2d732z4wa+yMIgAsVskMM18rPxrWP
         I6YUPF/6Aitl2QF+6cZEqaAsUGV79N/2w4xpwFAzhHSVJi/ASxyy47J7SactKltzY7Ol
         bquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771376200; x=1771981000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBiLc+HIphpolHu94PLKkkc7XOK2BREB30WnqZUZ20w=;
        b=MTJJbCLzYNiFXVVP9wrHTScdqW4aKx6mhM4bjemXWUqbnpiJfaYnvX+MXjz4CWOLho
         iTEdzjAgt71kFSUskPWdHhc156r2zxN28JWPxkSboODIgZ0i/kueYOI6MGJR6kYEpZyz
         doeZtbeXEI5dI7X8sKAB4hjf/8fxJicZ4tJYujZ+Uk2kp8mzVWmYigfpOqgjRLBhX1lF
         U4hPZRtIDShWX62h3o8HrKVCSQVroCwLVQ3pTY/EnOesedeq+MAU2dGr4EP/IC84SqiT
         mRHpYmIKfNh3649RlNXvrbtyMwz/7V8O2kvriQj/cpapb/NfUMPxUgw4esrNi+BM84ba
         ORsw==
X-Gm-Message-State: AOJu0YzdzRgcYBKNVDm7gjHJBOtNVkAOFe2RDBosyGwBwj5OQM+oIBK6
	427/HhG1GNKdclbmfu3ZOWdCeL3fS/O4EAJNK8by8ZzeAFFIObNt/NhcO4Q0Kit5fbUSq/mKQWU
	jKxKd4309L2adn2vLYwxnEiTYyP8Iddw=
X-Gm-Gg: AZuq6aLoq5mPwIuCju/ltZ4rpsb0qM4LrXnskr7bD7hz00WxyEpCLRYm25XCgBaHr0B
	t8rpq4W06S9RXL4t8oz8mpEtu/H0Qo4t0zaEzdl0pl47+Bpt1KHvCJaKv6yZGDtkWca2GGW1ipY
	p3/2cs278iusHbvCjS0S1EjLqU3YBpSLCs2QT2K1PVrEDJC0m3df6XSpLEHoa+H0LOkM8PIchDs
	D3ATUs0BCyigHCEkCgafBme6wpu1tCYxwQk/+ZRmEmfXnKlR5iVhhn0boxf+ji7QJX94hABVw4b
	wvmMLdug4vS58wnE0VJG2gako1d/oM7SRuGBgZGJwlDmk7CW5Wd/PsNrHlkvPAVfx3lyBoHrwWe
	yG8g/gZET8ygqOnE8moqyJyuUHw==
X-Received: by 2002:a05:6000:26c6:b0:434:2569:275d with SMTP id
 ffacd0b85a97d-43958e0cde3mr219465f8f.26.1771376200218; Tue, 17 Feb 2026
 16:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217194150.734701-1-kuba@kernel.org>
In-Reply-To: <20260217194150.734701-1-kuba@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Feb 2026 16:56:29 -0800
X-Gm-Features: AaiRm504gnK9xmmu_1emvgyzHnoF9upi1wY5jWzOyaGhcpR7iRZ09MKduMonfD8
Message-ID: <CAADnVQLQe8JedFM1DTweX=JSSW_rPg9z5S0u1B0M0V86DWhRYg@mail.gmail.com>
Subject: Re: [PATCH bpf v3] tools: bpftool: fix truncated netlink dumps
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 11:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Netlink requires that the recv buffer used during dumps is at least
> min(PAGE_SIZE, 8k) (see the man page). Otherwise the messages will
> get truncated. Make sure bpftool follows this requirement, avoid
> missing information on systems with large pages.
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Fixes: 7084566a236f ("tools/bpftool: Remove libbpf_internal.h usage in bp=
ftool")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Applied to bpf tree.
