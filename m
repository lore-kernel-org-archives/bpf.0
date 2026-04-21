Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86E39D6D9
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805943; cv=pass; b=pBwPlWs1sePIElb5SNAuWGf83j2WAqsg+4ye0N/JQukazc8qyf+ptMVEi9jLkPeofNW9cRm3HqEtnh0TWuJNBat9ZR1157F2inmSwF/UPCYwt6sE8H3U5JXk01h+gxf/VQDBRHMDnQXVGBY/x130YlVFunEZhj3ee5O4p2hTk04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805943; c=relaxed/simple;
	bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJagvdfdb00WqyIOPOyU3FoSu2CtFT5FnsUjfWrHds17HOoq1rQ0XPLIsyA+Vo5WzOloFhDjNicXrAoIsvtLmX7Gga0D2ukM+03lASQq7sfLyz0OkxPPNjSxhobHj524mz9AT8P8RMrSf73RyPWzfKW0HUA7hJBCiwgQ879JyZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkbVLyyw; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkbVLyyw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so29884405e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776805941; cv=none;
        d=google.com; s=arc-20240605;
        b=C7I1RSoqmh7ielIq0g4Srn9PbDBJyiyMo6VmkemqDx+zCGJdpWl2kezAp7H49eCKQr
         wzgKQ5wzuP/+gYNkNwMNya456LbvNjUSai8p5V9zhbXCKeUBO3m/TwOgRWrAYZf9ajL1
         a2cmN1voayMY9PIDBGsfsP0O/A946KBSA0pQEuJM70v9ieqjsYC0DwXIRPyqbfOlBRpZ
         BNg5iXGTrkUGLwvC4lPk1Yzr7ICr49ynFZffRIh9cj01GBwCPakBa7remrwwN3umeRLG
         E6KKxbHIf2k1Qe7Lw/BZZqNtc0tCKMUc3t7OE1JRgfCPLrax3byP5qY9yWGzywHWRMLg
         pZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        fh=anxemdP9MSNwYugz20ALNBspdbDcpDPLFoNUjc6Qu+w=;
        b=fBsr5R8wq4ywf2yLStwGElC19JBBXlcsk/wfOTTkEUrlVKvKPNhtLxXo+VponWzrSs
         Maih4BhAz1+4alTH6KE82fkLfF2pKMZI5VUJHtHrQ5Elvynd94JV08JVS38wJcqJUgei
         j+yoavaBl8ORzxbMkAtisZqAM+qdEMOY+ouRNkm4Y5MsU+lbw8q6Qi6enOjoWTilCnZx
         AgAtAD4NyEaUTD1Xa8JheIkQw1XglRs7NA7inkCaeoMJ/qa2JfFEABqWtIInDfm6htoF
         Shm/KPN+sfP+g+v8pxoOEZs0Yo3yQLdxsGE7UXNWh/0SMP710R2kjy/NhPGS87kte+ov
         dPeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776805941; x=1777410741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        b=RkbVLyywW2pe/i4FFjsAP7VdfebLNgXH7ZVzfuva3izAtjGOeyqkEo7o3tgUCwpr99
         Z+mOJ3zxtRqvZ8J5yknE+0x8tDTdBDH63F3lGsQdlKjHnDmR+IKw/jBCPSBS9ULrq8HK
         oDn1MtqO+ko0Ybh70mlMMWMAS6+rHkxF5Ax597BNkgWxUwwSwU54e/moXxQ2Eb0SlYrd
         zShZzFNWG6Fv+EmMiQSE6PshcaKiQrmfRext32vmNrsk5vYc/dBZL1yRtq74tjbhk/Sd
         +TIsYR8sqSoL6m4qRdJ2pPR5cp92OFhCJOFsC9+xBcArqFgaxLw6KUIBpgrvqRCQX77K
         hy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805941; x=1777410741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7HtXPblbsuvKQcLa9F8JHADH0B5A8obSovRJxaTmcEA=;
        b=kABYBnMZiCgfYXT49F6CB8JnJm7IJyTAkJ+FiuwyE1RyjTwGgrLrpPfls6tV4XJgfT
         ykYtVjMAn6Vr3wB1BhpbOqeiH8KeN5DtcOJR/c+Oqn7oXleE8ttW3sayBal1AFt01YCG
         y+CWWJteaOP+bmockTo7zmZSQJcERZzm0TL9yuySbUqayucdsb1PzbyVeodRybC5QWRt
         GlT/YnD2RmB8iPJ9ZCklspPM0Yizsqn7vLQdoM8BjHf240ajeCgKsmEvde/OahxIHIns
         bXxXmteyERjElf1yAR8JeXXp3cD5/Xi6ACTTcbXvVdAEwy/aKJxibv62ocGlg+e5t8yl
         e+Eg==
X-Forwarded-Encrypted: i=1; AFNElJ87ZyzR1F38cfV/VyfWyk5lffPcCdj2DL9wd+fFGvN/GMJjUaoHiBc6efuHeyUvnjTopVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7i4vk6fl1iTkRFPI7B2aayPKJzsSdh/Y+XT8hQLMyDuCZGSV
	N69OcgrVhQK+fzu8hEFz4Z7SgYyNSVsU7VLxQV+bbdPgU0mC/rffT9ABbslMbJVg2oRW1tkTifP
	s8fKa6VU0ZtB7PpzRXNWIKAeW7N3iOiY=
X-Gm-Gg: AeBDieuv/zX298WrJzMDcmeGVAadBVdO2bsNXPLDW2UZQpPea/1A1GPrZjdvx4BKL5v
	AqHtUZ6GYKu7BlFLpab7w6nEKfbysHj9iWm1ohRag5nzyKqMIxkRe1NulPkmvU49cxcuSLX2bvN
	S7cuaHrp2Me7IsYne4l7IdRWiLVWuwumgDZb5/GvCrZ/5fRcToQdkLr9XO5iNNr7Etimx6lqUgc
	jLl/HMveZJQ0gKmYAP6NwP98DEYd0JJ2rtr+m2l6OCJDA+A0XcrnIcdS1dShDrCPcIutbKRVRqN
	8KnODJnsTkt9OYmOsKWPloH9e0GR8vD28Sfuud7k3azqA/N3gFTrieETgWlEr+aD+AS1Awnu4ld
	7t3phvQvUfqzpDtBqSEAZHUCJFxAkrclX+Bco
X-Received: by 2002:a05:600c:820d:b0:48a:569c:abab with SMTP id
 5b1f17b1804b1-48a569cadacmr54957095e9.14.1776805940737; Tue, 21 Apr 2026
 14:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3>
In-Reply-To: <aefnIw1Tx_2r5nkS@CMGLRV3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 14:12:09 -0700
X-Gm-Features: AQROBzB7FEGFcLIjJDbSZzRa8uWl-Vr2UW5AqVzs9gp0AZcsBB4lKtYQM5rh6eY
Message-ID: <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Frederick Lawler <fred@cloudflare.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 2:07=E2=80=AFPM Frederick Lawler <fred@cloudflare.c=
om> wrote:
>
> Hi folks,
>
> I was accepted to speak a little bit about this patch series at Linux
> Security Summit this May [1]. I'm going to use this opportunity to
> re-iterate some of the motivation, what can be done today with BPF,
> drawbacks, and wrap up with discussion topics. I'd love to hear feedback
> from audit, BPF, and security folks to work towards a viable solution tha=
t
> addresses shortcomings to allow for better integration with BPF.

I don't think any bpf folks will be there.
Also giving a talk about it doesn't make it acceptable.
It's still Nack.
