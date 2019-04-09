Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57855C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 19:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA2E20820
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDITfL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:35:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:58612 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDITfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 15:35:11 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDwWS-0001xp-AX; Tue, 09 Apr 2019 21:35:08 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDwWR-00036U-WD; Tue, 09 Apr 2019 21:35:08 +0200
Subject: Re: [PATCH bpf-next v5 04/16] bpf: add syscall side map freeze
 support
To:     Jann Horn <jannh@google.com>
Cc:     bpf@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com
References: <cover.1554731339.git.daniel@iogearbox.net>
 <02cc454f12646ae96647457d64d41ba3577e3ae5.1554731339.git.daniel@iogearbox.net>
 <CAG48ez0V5L610YsJQde_r=BZgK1ghc-AuWTn1gF0oyLNNz4ctQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <58268396-8e08-8be7-d596-124d9ff887ec@iogearbox.net>
Date:   Tue, 9 Apr 2019 21:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0V5L610YsJQde_r=BZgK1ghc-AuWTn1gF0oyLNNz4ctQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09/2019 08:46 PM, Jann Horn wrote:
> On Mon, Apr 8, 2019 at 3:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> This patch adds a new BPF_MAP_FREEZE command which allows to
>> "freeze" the map globally as read-only / immutable from syscall
>> side.
>>
>> Map permission handling has been refactored into map_get_sys_perms()
>> and drops FMODE_CAN_WRITE in case of locked map. Main use case is
>> to allow for setting up .rodata sections from the BPF ELF which
>> are loaded into the kernel, meaning BPF loader first allocates
>> map, sets up map value by copying .rodata section into it and once
>> complete, it calls BPF_MAP_FREEZE on the map fd to prevent further
>> modifications.
>>
>> Right now BPF_MAP_FREEZE only takes map fd as argument while remaining
>> bpf_attr members are required to be zero. I didn't add write-only
>> locking here as counterpart since I don't have a concrete use-case
>> for it on my side, and I think it makes probably more sense to wait
>> once there is actually one. In that case bpf_attr can be extended
>> as usual with a flag field and/or others where flag 0 means that
>> we lock the map read-only hence this doesn't prevent to add further
>> extensions to BPF_MAP_FREEZE upon need.
>>
>> A map creation flag like BPF_F_WRONCE was not considered for couple
>> of reasons: i) in case of a generic implementation, a map can consist
>> of more than just one element, thus there could be multiple map
>> updates needed to set the map into a state where it can then be
>> made immutable, ii) WRONCE indicates exact one-time write before
>> it is then set immutable. A generic implementation would set a bit
>> atomically on map update entry (if unset), indicating that every
>> subsequent update from then onwards will need to bail out there.
>> However, map updates can fail, so upon failure that flag would need
>> to be unset again and the update attempt would need to be repeated
>> for it to be eventually made immutable. While this can be made
>> race-free, this approach feels less clean and in combination with
>> reason i), it's not generic enough. A dedicated BPF_MAP_FREEZE
>> command directly sets the flag, allows all pending operations to
>> finish and caller has the guarantee that map is immutable from
>> syscall side upon successful return, which is also more intuitive
>> from an API point of view. A command name such as BPF_MAP_LOCK has
>> been avoided as it's too close with BPF map spin locks (which already
>> has BPF_F_LOCK flag). BPF_MAP_FREEZE is so far only enabled for
>> privileged users.
> [...]
>> @@ -857,8 +870,7 @@ static int map_update_elem(union bpf_attr *attr)
>>         map = __bpf_map_get(f);
>>         if (IS_ERR(map))
>>                 return PTR_ERR(map);
>> -
>> -       if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
>> +       if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
>>                 err = -EPERM;
>>                 goto err_put;
>>         }
> [...]
>> +static int map_freeze(const union bpf_attr *attr)
>> +{
>> +       int err = 0, ufd = attr->map_fd;
>> +       struct bpf_map *map;
>> +       struct fd f;
>> +
>> +       if (CHECK_ATTR(BPF_MAP_FREEZE))
>> +               return -EINVAL;
>> +
>> +       f = fdget(ufd);
>> +       map = __bpf_map_get(f);
>> +       if (IS_ERR(map))
>> +               return PTR_ERR(map);
>> +       if (READ_ONCE(map->frozen)) {
>> +               err = -EBUSY;
>> +               goto err_put;
>> +       }
>> +       if (!capable(CAP_SYS_ADMIN)) {
>> +               err = -EPERM;
>> +               goto err_put;
>> +       }
>> +
>> +       WRITE_ONCE(map->frozen, true);
>> +       synchronize_rcu();
> 
> What is this synchronize_rcu() doing? It seems like your intent might
> be to ensure that all pending writes from the syscall side have
> finished by the time this returns, but functions like
> map_update_elem() aren't in an RCU read-side critical section when
> they check for ->frozen, so that doesn't work, right?

Hmm, yes, true, good point this would only partially work. Considering
that, it's best to just remove the synchronize_rcu() from there. Will
do a v6 with that part removed.

Thanks,
Daniel
