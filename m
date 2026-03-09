Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726D2D6E72
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077653; cv=none; b=qlmTmqXXUIj84OW1ru7evyCZsWM9Jn0mdFphVfn5Jn9YIMmkzsagW3kpwQfj26C5z5xjVIjLL2DpZIm3f9pDyAXi6O2lOfl8nsxdMop0n+cdFCUNsDAZqUduC1mZY0IewaEnS3sP5gceVF93P17JCWe0UdgLXLbAWOh65evK9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077653; c=relaxed/simple;
	bh=LcKBSGkUJ4jOZjfNY8MJfZV+UOABBnNyslHE4iTDcoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWWGk+rlOhXCrRvRvix3BClJdPQTLMy1uVahme3M3rrTrs9vHe9dmkrhjzAHzfiwlpJUH4QMbvH71tkJKflsRdPBlgCFLSRNt+3jGTdeFF/5RREbP2frY5NGPs3VV0hGVqB5mquVrSEL+Y7RR5P9O/X7a+431GUV7yzBh5vTYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dVQ2KLQB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dVQ2KLQB"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so7902616e87.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773077649; x=1773682449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/0fgmHhC0VOep6ZWbqzX4YfecogO4RJ08oTSaCn8/k=;
        b=dVQ2KLQB8jp3kX/d8cVZdvibwnGGIroW6pSitqeOGpRpYlZJwmbcvK8CgPysaYAvB+
         q1ZRCdgNDFWvMdecQIKBSQLHBHS8loy6IiJGQYUW0UZZbMSjRgbuQrLjWXbLPbdC899w
         RMnvXxoydh5ee1ye3jgjAaHjk+SJ7sViP1XNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077649; x=1773682449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/0fgmHhC0VOep6ZWbqzX4YfecogO4RJ08oTSaCn8/k=;
        b=GNyOIamACUrSEWM/6yCr97dz5zo4ZGMjFWYm9KeBU5u8ORbqF7Dx+45Z9FI/jQnHmg
         8lCS+47cLChbNnFZL3J52eNxC8hnhJl9JJm08WE6J8kZkASPCmD9VEqaF3s6nOldhUxB
         jvmTu1hKB7kBPgkYZqqaeFbrEpMD6UkgsoOPjPgWgepF6FzULXA1t1eyeEw+v9KV8gZv
         th3Pa7brxOmrX7ZK6Y4QpVs0McFmGngJ44vi74qvZD88b5IIJXtpn63GCz6E/3igND5S
         RpkpPvUTyAchu36zMqieXbR3CiTMeh0KNAIPwMYWwdSpHSiYOZ7SQIiB665ekk1H8FAI
         7huw==
X-Forwarded-Encrypted: i=1; AJvYcCWQEZQfc1EPtNmdEtQwdJXlhzFcIuAilAJ0Z65VaMacY0iRBxyYbvK70mo/MlLKLHi5ca8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRSScRWLgSVD4QXyTJ24nvB/ypRITx/p9ZfbWnVtd3fY9e+6H
	6Lof8jO3OqVyppkWWZ71IbMfvb1hks5H6zeHpTdJg0q8oIG3DVnV1pvaMPJ0ClYALgDdIXPZTMd
	NuZUZWm3/cg==
X-Gm-Gg: ATEYQzwVhm1rDhtTsCMa0bbCVlRRcfNqyMVOhgKPM4s8d0egqx8ljEf+5r5I6jsWSIP
	Qca9+WeNcoMhqwUDekRtJ7jgEo/By5fCCpbGYhL3g3ajJ+sTeV9ugQ7Z+6wq1Q6bcfuC8gDP5JT
	ol1k7s9j16GFgpXwm8T0L/aY//spqC7K16XXRQQnJEuvA2uBcyfpj9qfVbzN2BvKet3M9s2Gf/P
	QfenW5BpeMs5Dy+zGpcx64L65VOzBqMbmba44AIv68NuHU0l3nL/YcfaSHQii7Eme3baspkWeC9
	O3l6//P1Hyj9TWkHNW6FMmRYPh7g1bWA3rBJt30J3Uku7XAwYR312eCkgfT5XFCn6pkYQ1ZJVGe
	q5LDW3MHJPMfrUFf1WmafNDT5NPXZ/WhzPIqNTrqOqfov9Gg1S432Xr6TytNcCeuah3BLAwEAxP
	QPWtBX1eDjEgdKu6Yq3aiJbL8/Pj5u6TJx3BCPV9yxRCusUF+1+0GujF3P+7FlYSgegglYlT10
X-Received: by 2002:a05:6512:6098:b0:5a1:3551:723a with SMTP id 2adb3069b0e04-5a13ccf2c7emr4137077e87.29.1773077649249;
        Mon, 09 Mar 2026 10:34:09 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cf1asm2264739e87.9.2026.03.09.10.34.08
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:34:08 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so7902586e87.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:34:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSe+DeOUO6JDLoe1AgyN3g+CSMMOsnrrg8IHOMClWgXkef0def58oJnmHtVrtC61GaaTU=@vger.kernel.org
X-Received: by 2002:a05:6402:50d4:b0:65c:23f0:a80d with SMTP id
 4fb4d7f45d1cf-6619d4e3738mr5814793a12.19.1773077289768; Mon, 09 Mar 2026
 10:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org> <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
 <aa7qson15uJpL-BL@infradead.org> <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
In-Reply-To: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2026 10:27:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-QpnBHMH4Oa6tsYVhp+Uv+hKU_oedAUnt4icMqwPtzQ@mail.gmail.com>
X-Gm-Features: AaiRm50OcoxR7YXKVzqClnrYq6PJcpS66d_jgF8-UVsQY5IDs7VWWvYFcU4JSa0
Message-ID: <CAHk-=wi-QpnBHMH4Oa6tsYVhp+Uv+hKU_oedAUnt4icMqwPtzQ@mail.gmail.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: multipart/mixed; boundary="0000000000000491e3064c9abac4"

--0000000000000491e3064c9abac4
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 09:37, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, there are real exports in this area that are actually strange and
> should be removed: for some historical reason we export 'free_task()'
> which makes no sense to me at all (but probably did at some point).
>
> Now *that* is a strange export that can mess up another task in major ways.
>
> [ Ok, I was intrigued and I went and dug into history: we used to do
> it in the oprofile driver many many moons ago. ]

It looks like it should not only no longer be exported, it should
actually be static to kernel/fork.c. As far as I can tell, that
historic oprofile use was the only reason ever this was exposed in any
way.

IOW, a patch like the attached is probably a good idea.

Somebody should probably remind me next merge window (I'm not going to
make 7.0 bigger, and I find examples of people using
kretprobe/free_task, which *should* still work just fine with a static
function, but for all I know if the compiler inlines things it will
cause issues).

Or just add this patch to one of the trees scheduled for next merge
window. I'm not currently carrying a linux-next branch (I actively
deleted it because it caused problems due to messing up other peoples
linux-next branches, so if I ever introduce one I will have to come up
with a better name anyway)

                  Linus

--0000000000000491e3064c9abac4
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mmjgdgcc0>
X-Attachment-Id: f_mmjgdgcc0

IGluY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oIHwgMiAtLQoga2VybmVsL2ZvcmsuYyAgICAgICAg
ICAgICAgfCAzICstLQogMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaCBiL2luY2x1ZGUv
bGludXgvc2NoZWQvdGFzay5oCmluZGV4IDQxZWQ4ODRjZmZjOS4uMGVkYjM2MTA3YWM1IDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaAorKysgYi9pbmNsdWRlL2xpbnV4L3Nj
aGVkL3Rhc2suaApAQCAtMTA2LDggKzEwNiw2IEBAIGV4dGVybiBwaWRfdCB1c2VyX21vZGVfdGhy
ZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpCiBl
eHRlcm4gbG9uZyBrZXJuZWxfd2FpdDQocGlkX3QsIGludCBfX3VzZXIgKiwgaW50LCBzdHJ1Y3Qg
cnVzYWdlICopOwogaW50IGtlcm5lbF93YWl0KHBpZF90IHBpZCwgaW50ICpzdGF0KTsKIAotZXh0
ZXJuIHZvaWQgZnJlZV90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKTsKLQogLyogc2NoZWRf
ZXhlYyBpcyBjYWxsZWQgYnkgcHJvY2Vzc2VzIHBlcmZvcm1pbmcgYW4gZXhlYyAqLwogZXh0ZXJu
IHZvaWQgc2NoZWRfZXhlYyh2b2lkKTsKIApkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tl
cm5lbC9mb3JrLmMKaW5kZXggNjUxMTNhMzA0NTE4Li4zODVkODA0MzJhODkgMTAwNjQ0Ci0tLSBh
L2tlcm5lbC9mb3JrLmMKKysrIGIva2VybmVsL2ZvcmsuYwpAQCAtNTI2LDcgKzUyNiw3IEBAIHZv
aWQgcHV0X3Rhc2tfc3RhY2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiB9CiAjZW5kaWYKIAot
dm9pZCBmcmVlX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCitzdGF0aWMgdm9pZCBmcmVl
X3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiB7CiAjaWZkZWYgQ09ORklHX1NFQ0NPTVAK
IAlXQVJOX09OX09OQ0UodHNrLT5zZWNjb21wLmZpbHRlcik7CkBAIC01NTUsNyArNTU1LDYgQEAg
dm9pZCBmcmVlX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiAJYnBmX3Rhc2tfc3RvcmFn
ZV9mcmVlKHRzayk7CiAJZnJlZV90YXNrX3N0cnVjdCh0c2spOwogfQotRVhQT1JUX1NZTUJPTChm
cmVlX3Rhc2spOwogCiB2b2lkIGR1cF9tbV9leGVfZmlsZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwg
c3RydWN0IG1tX3N0cnVjdCAqb2xkbW0pCiB7Cg==
--0000000000000491e3064c9abac4--
