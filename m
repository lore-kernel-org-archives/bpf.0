Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178C372B32
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529001; cv=none; b=DqmaCrGWTgwNtLG4hYZ+v9okwA+MdumUOBYJj6N92GarHJJOmDJJUBtNwDQE4gcPNjaCXZdapeInDEdMxOKrlDyHUYAPuSjDmxue4U/VXPG4uZGAUNBe9C5Ey3S3pC2eqopw3HpRr3spQBTWosi+RYHFNXn0rch4ZT4fvvVKE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529001; c=relaxed/simple;
	bh=fT4Wh7zLimmN8YPV2rfhV4SibyXoX/Z38RLbsH3AQK4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Ofs89+GkkHOiPc78zOwuuAmfRGBA4E/2lHJNXOqi81Pacaeoz61TNnLUlcmdgbllJKx5tmewBlCdSINdoZJPEOfIOixBFUd5xuc1Zq+XuRuYeG2TUdXBhTqPF/QysZCqkJ2VczoTu957lN5HIGpUluB9tiL0Qj6Ijh9bjcAwvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsTVrI0k; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsTVrI0k"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f7f93b3d4so416582f8f.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785528997; x=1786133797; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jKBxHr4kakqx5giULQAhQrBpk8zyW3hvnaTsLQOKVHw=;
        b=qsTVrI0k9n+NaG5nRSTNcfGGTVu3qK0HTCtdPZzZ4nTOh0oiH+9HqnB+2YRwbMGrCJ
         mBTdljhXa3aHVXMBFKq1wkBkx/fs1RiufxfykPN8fX7wvmDunGFbHiZI3rwgsLZoskzd
         qiOH6zeAYvTQy54PtNPpu04WVBZIRx0/g0rcCUgZ8HiG57akUTRWRpiC9loFmoymXOAy
         c4ah1O5pK3kxmCgSUx1H/jRcOX/VZqCqlPNhYjX2OvxiKrl0FLZGkdb8LbhkRFnPapfF
         Vx1A2mPyIMb+5np+gO9GFTDQcMVXJP9pdPlP1BecWTcT8idK/mcLVxDQ2MvMmdpt8eLL
         tCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528997; x=1786133797;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKBxHr4kakqx5giULQAhQrBpk8zyW3hvnaTsLQOKVHw=;
        b=KE3sjh01Xi/bA/W4WDdt3nqNcxh4ZIX6bqZ/36uMAURPdCkcd+GhFJEbhhVjUbqImw
         zLhxkmw73y0Bk3WDN0T0z1m2c4ahuyOjBeztLx0THtH2urxHG9p74a8eAhbbKtDB1anR
         Sz6K42XjuPh4O5LhUN9Ai+OWVVAtY9vNPfOrBM6xz2xllwzbPDQ2gltEFWa7A4xfBd8a
         Z27MXQXX4RsCK3Pu1ozvmu7rdaQcVz4g4tmVBbR4f01AeSlSs5UHfCoE64CerUPTLQmf
         XbzfNsjezrxyQpAHswe3zEVfkhdNqR/+I6WKhi895/InP5Esk0zgfPzUFpw+vHlP05Jf
         1ihw==
X-Forwarded-Encrypted: i=1; AHgh+RqeNozsBH6VLvvAIKx3a1owChPY2CAErzy8ovC9Ej5b22NABJBylpWjncU2MqdySw4BRaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8eIYL/8x8KFeyP0KgtIe8YKw5WrhDBpFZ2OTkZwiTe+uWLBE
	FNna0GVaXiLDteQl8NPjHmnEjyYHokMr5UovNOpkIFMzKCBQLBSt4yr9
X-Gm-Gg: AR+sD13NfirdDvAy0R3hpCBdEQvwGNwi7GtYAmwOE4wY/F5Pe9dLgb5QxR7O6/46BxQ
	0AZxPwzVw8W41hI/1gubkaJkUoddo6UKd/K8xes7S4oovFPpFA0nyyQZqLSFBRCGlZPpZWPpgNy
	73rw99mC5zhFJ5oEVIps4U93KExz7ifHck3Mh0L8dd1XsC3c1PkVYKKbwxcons7hEuiYXfs5y7d
	xUd9zGUasPuwE8484eK1JEezefGfgGPbKEasXz9NqzQF0h6GJ119M7TH1fegvvVQWs0JyuErz2Q
	uDEi4WbjCmiDSuwjpO+jhfEvL/h9vRcOGuJ83jjmwHV4jDNB3nVL5UDHOuGSQUdSE/FnFMnyM5J
	qO8n59D5fceCz1HfjDP5a85sW2J/L0NDgqi8MXBZJTGEutQF5Hpcefg/xc901z7KsU194OqFvU0
	3jGWe1OiCkyZTUX/F/FzSAUlTTwKgox1PSk46qJu9L9qLr5zOiqMNvp4WQT3gPnwLXrbsWyuFSb
	8kusGmiCiqGbmuzUP/p2NdXgdr2Lv3ICLfdUYU3IHFNU687ClIg6JHLVHpWjjzbjWvcyg+QyanW
	UuRjuHXEBYvlUB7f1hShrY2gIzU=
X-Received: by 2002:a05:6000:4205:b0:47f:77a8:7e20 with SMTP id ffacd0b85a97d-47fd7308f0emr2136026f8f.35.1785528997285;
        Fri, 31 Jul 2026 13:16:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bf7csm8953678f8f.32.2026.07.31.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 13:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 22:16:36 +0200
Message-Id: <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "James Morris" <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>

On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwiv=
edi
>> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@=
paul-moore.com> wrote:
>> >> >
>> >> > ...
>> >> >
>> >> >> Yes, I understand you feel it should be placed under security/. Yo=
u are entitled
>> >> >> to your opinion.
>> >> >>
>> >> >> No, I do not think the newly added kfunc is a big enough layering =
violation such
>> >> >> that we need to do it ASAP, disregarding everything else outlined =
above. I am
>> >> >> sure you see that too. There are several other instances of simila=
r kfuncs.
>> >> >>
>> >> >> Therefore, please attempt to meet me halfway here.
>> >> >
>> >> > I'm happy to work with you, and/or anyone else, who wants to work o=
n
>> >> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c=
.
>> >>
>> >> Right, and for that file to exist, you need to get everyone (FS, BPF =
folks) to
>> >> agree on whether placing all such kfuncs there makes sense. It is not=
 for both
>> >> of us to decide on our own. So let's revisit this whole topic once yo=
u've done
>> >> that exercise.
>> >
>> > The kfunc that David has proposed must be located in
>> > security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
>> > fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfunc
>>
>> Sigh.
>>
>> I now went and read the archives, and Christian already told you no befo=
re [0],
>> which I missed in my first read. So two people whom this code affects al=
ready
>> objected to your proposal.
>
> As mentioned previously, David's kfunc has nothing to do with the VFS.
> Look at the code if you haven't already and you'll see what I mean.
> The only relevance to the VFS is the fact that "inode" and "xattr" are
> used in the name; David's currently proposed kfunc is an LSM kfunc,
> not a VFS kfunc.

I am sorry, I read it and I don't see why it is an LSM kfunc. It is absolut=
ely a
VFS kfunc, that is using LSM APIs to some end. The LSM specific bits are al=
ready
in security/.

At the very least, it is a mix of both, but definitely not one or the other=
.
Therefore, the situation is already ideal, code owned by different people i=
s in
the files they signed up to maintain.

>
> If you find yourself required to abide by Christian's comment, despite
> this not being a VFS kfunc, that's fine, but this puts us at a
> stalemate and David will need to find another approach for his work.

Paul, let me remind you of another email you sent [0], in which you contrad=
ict
yourself. I don't know what caused you to get confused over the month.

In it, you tell David to move *LSM* bits into security_lsmxattr_add(), whic=
h has
been done in patch 2. Thus, by your own characterization, it means the rest=
 is
*not LSM* code.

Quoting you verbatim:
> As I said previously, if you absolutely insist on the kfunc being in
> the VFS kfunc file, the LSM specific bits need to be abstracted out
			^^^^^^^^^^^^^^^
> into an LSM function.

You yourself made the point in that same email that the kfunc can stay in t=
he
current file once LSM bits were moved out, and your request was honored.

At this point, anybody reading this thread will only see your position as a=
 way
to undermine David's work and waste everyone's time, such that you can grin=
d an
axe against BPF folks. It's a repeating pattern.

I tried my best to engage in good faith, but it is clearly not working.

 [0]: https://lore.kernel.org/bpf/CAHC9VhQd0-N1g=3Dg8gspeV7bhLz0LA6DF5HZyB7=
mW6VW_7oSt2w@mail.gmail.com
