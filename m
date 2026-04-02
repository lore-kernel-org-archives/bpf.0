Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71A3EF0A5
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141797; cv=pass; b=RMv5aM3ku7qqvFWhAx36T46zPo4JO6K5yzRD8IqhSXi/+zkvuiMdOFjhFzuOdc1qfmeLpTJi98HPKM00cpm4F9LMSHw+GQ4UVKMbrD/PozkOTNYh0ccSTu5tmtDnArSYCdwj4h3CJgUJ1/KOldJlLyoM1UHADOiiPFrbaLTLXdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141797; c=relaxed/simple;
	bh=uAxS5YiO1+amAvCpAqHLE6/1cSDNss5no4TdlFmkOU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5yo4oBGcninZItua7nWsHmKqjdoCdgKgKCKhRAEoHB4373MhbIo88KZ/j9TNs5TgYWdFtYOmluiAiC7wbE7Jppdzp2DgSSNkq7pcNd2NaDZIuB/lK4FiVsSs0ZpN3xukOPzUNXTXEb1IwKgIGMQROaBFM69ZUNvoIBDurE2b6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7ecduwC; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7ecduwC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfa33a983so666327f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 07:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775141794; cv=none;
        d=google.com; s=arc-20240605;
        b=NrW2y//qcKmuLVHFG6wb6i15FDoit2KYk1+dFTG4r7TFeb26LDQGwVR4A3d2AL+/4G
         IM8++rPwXl0KMKPKyrkzewLath3LS/or9bJw4RnJ1rfVkVCVhwxrFyvtwYcX+uzy3P6E
         72diBOvqd00Qf3R51yTe6fJlriKniJYIVOGcZojC/XwMBAn4LUnhDJ2JOasLWZ6sJRGT
         vLBxFy1LKkLTlYofaW7yFQOTuBx9PChMnywAaPwMArxlxxSIYib633Ne8fIisIP/3Ykf
         7BN3QokzEJQnzbC8RPk0W+NmHW6qHOrG/2jk4iiAZ6CgfuMqmomDw4O0ympau5UKTU8u
         IU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAxS5YiO1+amAvCpAqHLE6/1cSDNss5no4TdlFmkOU8=;
        fh=opmEKAuYjf+L/Q6qsuYtE4IBXxKqBCcg8xJRhC3uCOs=;
        b=V5AhMeZ9SNOHQbXjz1M3+nuI5f/17Ebn8skrvhzsiFfRstPCWwAYJKIIAZ7kFfZycH
         XMVlWDVDHrsqMj/tYT/Dsjes6+qAnbK4Hk2y+P133vVUR0rDO7wA8qTpJ1fgAN2/f+Oy
         HZKWrZmv7WUrCjljV5QawN+8hfHLJEbe0oriGKhyymp6FC29HyNdQmsVQuqvEIA0/9ln
         X0dAILMPCMkBhseTXUh6ao5sE1kIZnG7LTd9Sz6q295MS4GAWsFdKwCc8vyHfDDaxSdF
         /qdb/pq6MdFG72XNNC+wRs3/WqnwDRbxoh6ioh5LgWUno/kbK1kHuopOl36rssUDT7JJ
         vMww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141794; x=1775746594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAxS5YiO1+amAvCpAqHLE6/1cSDNss5no4TdlFmkOU8=;
        b=a7ecduwCKqG+W0f4z/WUDVHuW4iD3tc2r9nLlN+zov7bEAojLWwRmhFzHH8O90r5gQ
         v5bmac2v66e31c6PFSxbP/nL8149rTgUkWX/N+j++/gdQoAbXKmmGvIHvHNlTPHnAjpZ
         uc1JejohkfhxGARs7fKspcDwgX05whEG6nuPfkIV1car7IUFEbIDbfw7XtJZZdA89ff2
         5vy8+q1pvTPZ3U8HLcUjVnj9/JH3WTrkAhHAbgwglxTicrCKLHMUby0cxJwjRxLxuy+3
         w5kWYD+cmVEl9C7hKLHtJvBwaL900978K9Y2+0yaMMHqyvqxbKx1IQguSLUSuwaLIM9s
         F+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141794; x=1775746594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAxS5YiO1+amAvCpAqHLE6/1cSDNss5no4TdlFmkOU8=;
        b=oxhOMRZ+HMi5g0gSH4fMkhNSodMjELBNxV8Q5C/0SBPVs7tGSICrnj1tw9LxlM1Yvx
         l0jC5e4n4p0akSpVAMfQ0MgX059H+yLV/vrh2IX+bA9CBOPrb03+5V4yAlLi1D58/IFR
         fVvj8fEudUv6xUrH8qaN8kXL8gozyp6gRf35jD38OLy+cI4K8iJV7EmZ5pvYDKxXlgRf
         DXP+VweJsvJvLfvTsfRaXsndQvyfeCQvjPTQAwRpYGE3c9Mkxvnk74y7QQZswhGuNwbz
         WXd14yva8VuzmeQ2fm9hyeqP3dvRSISrFs+IswfX/KnhNkqr8moDdpSfSwJkhzeQq1VZ
         x8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWwVCxFtMKEzrULFXe7c7aab22lzYjxl5NafCGWIRGLDT6xf/XoRGH8OkojQ555HuEYuj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5d8Yr+4smJ63Ju47VVpO1QXD5GKR/AGwFGROhVPwEVBdVsCQh
	E0puNl6MWYsnGIe38KtLDrGH0vsITnLI793TDlC/kY2jnRzKL3Uz/wKDSx73A3z9fwZA9bFSlqD
	jjNf+aRIIWWPKQT5wVgaaf0hEKbHeTvc=
X-Gm-Gg: AeBDieter8E3FviswYHGMTSnhXhtXo4IEvK3queTOGUjnHpx34rPTyXaxKD9/B9hrnh
	vxjbn1R8OD58UQ5fDBDTV38lU+cw1XM4ETujTP1KRlmHk5OAjhMIC/Tl3NE+jaclcH8xzJh4/m2
	mmnIA/EjdYJBAMiYDFcPJuGk80qQKxK7l9yysCp45RQfy4A58P/lp82moYjxWrVWOGvcbhHwKU2
	2+kaPXF6fFExY5QYwEzHz+R3BTUi7GC86QgB1FBAFBrvpERMT/7U/r4RlTskiAD0Zq9khdQF9oB
	wLnPl+MmvwhpdE3Du8dvBBakzc12d6WCLz5jivh4ZxkexlquXMkKj7AyQkbRCU6L8aobZRhKCGj
	oANn6xmjqDY0dRCyuxnUCqtfllQ==
X-Received: by 2002:a05:6000:178d:b0:43d:4ee:c25a with SMTP id
 ffacd0b85a97d-43d150e3bd6mr13872675f8f.48.1775141793883; Thu, 02 Apr 2026
 07:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com> <69ce66da.050a0220.2dbe29.0005.GAE@google.com>
In-Reply-To: <69ce66da.050a0220.2dbe29.0005.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 07:56:21 -0700
X-Gm-Features: AQROBzCTm63wE0_zWPbun-baJuzBXrmRm165qIp6TtIjqCRaUBlXsXPm7P0F0D0
Message-ID: <CAADnVQKzKhHFO+JBRmF7QyH3C9p3Uu+MuJdK-tuiqnt-BGU6Zg@mail.gmail.com>
Subject: Re: [syzbot ci] Re: bpf: Prep patches for static stack liveness.
To: syzbot ci <syzbot+ci5d1af9c009034c4e@syzkaller.appspotmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, syzbot@lists.linux.dev, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 5:53=E2=80=AFAM syzbot ci
<syzbot+ci5d1af9c009034c4e@syzkaller.appspotmail.com> wrote:
>
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:21711:16
> index 10 is out of range for type 'u32[10]' (aka 'unsigned int[10]')

Yes, it's speculative out of bounds. r10 will not appear as const,
since loop that populates it goes to ARRAY_SIZE(aux->const_reg_vals);.

If that's the only thing I'll fix it up while applying.
